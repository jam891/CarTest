//
//  AddCarViewController.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit

class AddCarViewController: UIViewController {
    
    typealias DidFinishDelegate = (_ carModel: CarData) -> Void
    var didFinish: DidFinishDelegate?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Actions
    
    @IBAction func save(sender: UIBarButtonItem) {
       
    }

}


// MARK: - UITableViewDataSource

extension AddCarViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModelCell", for: indexPath)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension AddCarViewController: UITableViewDelegate {

}
