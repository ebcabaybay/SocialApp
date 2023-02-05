//
//  CameraHandler.swift
//  SocialApp
//
//  Created by Spam C. on 2/5/23.
//

import Foundation
import UIKit

class CameraHandler: NSObject{
    static let shared = CameraHandler()
    
    fileprivate var currentVC: UIViewController!
    
    //MARK: Internal Properties
    var imagePickedBlock: ((URL, UIImage) -> Void)?

    func camera(vc: UIViewController)
    {
        currentVC = vc
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary(vc: UIViewController)
    {
        currentVC = vc
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
        
    }
}


extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
           let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            self.imagePickedBlock?(imageUrl, image)
        }else{
            print("Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
//            self.imagePickedBlock?(image)
//        }else{
//            print("Something went wrong")
//        }
//        currentVC.dismiss(animated: true, completion: nil)
//    }
    
}
