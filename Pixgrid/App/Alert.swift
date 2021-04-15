//
//  Alert.swift
//  PixGrid
//
//  Created by Lau on 26/02/2021.
//  Copyright © 2021 Lauriane Haydari. All rights reserved.
//

import UIKit
import Photos

// Alert if an image is missing in the grid before saving
class Alert {
    func missingImage(viewController : ViewController) {
        let imageAlert = UIAlertController(title: "⚠️ Please complete the grid with missing images to share!", message: "", preferredStyle: .alert)
        imageAlert.addAction(UIAlertAction(title: "Got it 👍", style: .default))
        viewController.present(imageAlert, animated: true)
    }
    
    func cameraUsing(action: UIAlertAction) {
        let actionSheet = UIAlertController(title: "📸", message: "Choose a photo in your library or create one using camera ", preferredStyle: .actionSheet)
        // Camera access
        actionSheet.addAction(UIAlertAction(title: "tilte", style: action.style, handler: { (ac) in
            
        }))
    }
    
    func restrictedCase(viewController : ViewController) {
        let alert = UIAlertController(title: "Photo library restricted", message: "Photo library acces is restriced and can't be accessed", preferredStyle: .alert)
        let okAction = UIAlertAction(title : "OK", style: .default)
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
    
    func deniedCase(viewController : ViewController) {
        let alert = UIAlertController(title: "Photo library denied", message: "Photo library acces was denied and can't be accessed. Please update your settings if you want to change it", preferredStyle: .alert)
        let goToSettings = UIAlertAction(title : "Go to your settings", style: .default) { (action) in
            DispatchQueue.main.async {
                let url = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(url, options:[:])
            }
        }
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel)
        alert.addAction(goToSettings)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true)
    }
    
    func notDeterminedCase(_ status: PHAuthorizationStatus, viewController : ViewController) {
        if status == PHAuthorizationStatus.authorized{
            viewController.imagePickerController()
        }
    }

    func libraryOrCameraSource(viewController : ViewController, imagePickerController: UIImagePickerController) {
        let actionSheet = UIAlertController(title: "📸", message: "Choose a photo in your library or create one using camera ", preferredStyle: .actionSheet)
        // Camera access
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                viewController.present(imagePickerController, animated: true, completion: nil)
            } else {
                print ("Camera not available")
            }
        }))
        // Photo Library access
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                PHPhotoLibrary.requestAuthorization { (status) in
                    switch status {
                    case .authorized:
                        DispatchQueue.main.async {
                            viewController.imagePickerController()
                        }
                    case .notDetermined:
                        self.notDeterminedCase(status, viewController: viewController)
                    case .restricted:
                        self.restrictedCase(viewController: viewController)
                    case .denied:
                        self.deniedCase(viewController: viewController)
                    default:break

                    }
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

        viewController.present(actionSheet, animated: true, completion: nil)
    }
}

