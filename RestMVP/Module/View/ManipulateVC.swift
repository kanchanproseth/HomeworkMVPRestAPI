//
//  ManipulateVC.swift
//  RestMVP
//
//  Created by Kan Chanproseth on 12/16/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import UIKit
import Kingfisher

class ManipulateVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextfield: UITextField!
    let imagePicker = UIImagePickerController()
    var eventHandler : ManipulatePresenter?
    var newarticle:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        eventHandler = ManipulatePresenter()
        eventHandler?.LoadManipulateView(viewInterface: self)
         // encode the image
        if newarticle != nil {
            let imageURL = URL(string: (self.newarticle?.image!)!)
            let id = newarticle?.id
            self.imageview.kf.setImage(with: imageURL, placeholder:  UIImage(named: "thumbnail-default"), options: nil, progressBlock: nil, completionHandler: nil)
            titleTextField.text =  newarticle?.title
            descTextfield.text = newarticle?.description
            print("\(id)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func SaveButton(_ sender: UIButton) {
        
        if newarticle != nil {
            let imageData = UIImagePNGRepresentation(imageview.image!)
            eventHandler?.delete(id: (newarticle?.id)!)
            eventHandler?.PostImageData(title:titleTextField.text! , descriptionsOfPost: descTextfield.text!,image:imageData!)
            print("\(imageString)")
            _ = navigationController?.popViewController(animated: true)
        }else{
        let imageData = UIImagePNGRepresentation(imageview.image!)
        eventHandler?.PostImageData(title:titleTextField.text! , descriptionsOfPost: descTextfield.text!,image:imageData!)
        print("\(imageString)")
        _ = navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func loadImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageview.contentMode = .scaleAspectFit
        imageview.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func back(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Delete(_ sender: Any) {
        if newarticle?.id != nil{
        eventHandler?.delete(id: (newarticle?.id)!)
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    


}
extension ManipulateVC: ManipulateProtocol{
    func LoadManipulateView() {}
}
