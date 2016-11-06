//
//  ImagePicker.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/6/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit
//import Permission

class ImagePicker: NSObject {
    
    typealias imagePickerCompletion = (_ image: UIImage) -> Void
    
    fileprivate var completion: imagePickerCompletion?
    fileprivate var controller: UIViewController!
    
    private static let sharedInstance = ImagePicker()
    
    static func pickImage(_ controller: UIViewController, completion: @escaping imagePickerCompletion) {
        sharedInstance.pickImage(controller, completion: completion)
    }
    
    private func pickImage(_ controller: UIViewController, completion: @escaping imagePickerCompletion) {
        self.controller = controller
        self.completion = completion
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        optionMenu.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { alert in
//            self.requestPermission(Permission.Photos)
            }))
        
        optionMenu.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { alert in
//            self.requestPermission(Permission.Camera)
            }))
        
        optionMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        controller.present(optionMenu, animated: true)
    }
    
//    private func requestPermission(permission: Permission) {
//        permission.request { status in
//            guard status == .Authorized else { return }
//            switch permission.type {
//            case .Photos: self.showImagePickerForSourceType(.PhotoLibrary)
//            case .Camera: self.showImagePickerForSourceType(.Camera)
//            default: break
//            }
//        }
//    }
    
    private func showImagePickerForSourceType(_ sourceType: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate   = self
        
        if sourceType == .camera {
            imagePicker.cameraCaptureMode = .photo
        }
        controller.present(imagePicker, animated: true)
    }
    
}


// MARK: - UIImagePickerControllerDelegate

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        picker.dismiss(animated: true) { 
            self.completion!(imagePicked.crop(CGSize.init(width: 400, height: 200)))
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
