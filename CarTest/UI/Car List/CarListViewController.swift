//
//  CarListViewController.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
import CoreLocation

class CarListViewController: UIViewController {

    @IBOutlet weak var weatherView: WeatherView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Car> = {
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "model", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreData.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        return fetchedResultsController
    }()
    
    var selectedCar: Car!
    
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager()
    }

    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .CarDetailSegue: print("CarDetailSegue")
        case .AddCarSegue:
            if let navigationController = segue.destination as? UINavigationController,
                let addCarViewController = navigationController.viewControllers.first as? AddCarViewController {
                addCarViewController.didFinish = { carData in
                    DataService.instance.storeCar(carData)
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @IBAction func unwindToCarList(sender: UIStoryboardSegue) {
    }
    
}


// MARK: - UITableViewDataSource

extension CarListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath)
        as? CarTableViewCell else { fatalError("Unexpected Index Path") }
        configure(cell, at: indexPath)
        return cell
    }
    
    func configure(_ cell: CarTableViewCell, at indexPath: IndexPath) {
        let car = fetchedResultsController.object(at: indexPath)
        cell.car = car
    }
    
}


// MARK: - UITableViewDelegate

extension CarListViewController: UITableViewDelegate {

    private func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = fetchedResultsController.object(at: indexPath)
            car.managedObjectContext?.delete(car)
//            CoreData.context.delete(car)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCar = fetchedResultsController.object(at: indexPath)
        performSegue(.CarDetailSegue, sender: self)
    }
    
}


// MARK: - NSFetchedResultsControllerDelegate

extension CarListViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? CarTableViewCell {
                configure(cell, at: indexPath)
            }
        default:
            print("...")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}


// MARK: - CLLocationManagerDelegate

extension CarListViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        if currentLocation.horizontalAccuracy > 0 {
            manager.stopUpdatingLocation()
            
            let latitude  = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            let location  = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            OpenWeatherMap.currentWeatherFor(location, completion: { json, error in
                var weatherJson: JSON!
                
                if error == nil {
                    weatherJson = json
                    DataService.instance.storeWeather(json!)
                } else {
                    weatherJson = DataService.instance.getWeather()
                }
                
                DispatchQueue.main.async(execute: {
                    self.weatherView.weatherJson = weatherJson
                })
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager error: \(error)")
    }
    
}


// MARK: - SegueHandlerType

extension CarListViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case CarDetailSegue
        case AddCarSegue
    }
    
}



