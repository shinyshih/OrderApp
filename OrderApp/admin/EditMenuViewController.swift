//
//  EditMenuViewController.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import UIKit
import FirebaseStorage

class EditMenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func weekdayToEnglish(weekday: String) -> String {
        
        switch weekday {
        case "星期一":
            return "mon"
        case "星期二":
            return "tue"
        case "星期三":
            return "wed"
        case "星期四":
            return "thu"
        case "星期五":
            return "fri"
        default:
            return ""
        }
    }
    
    var navtitle: String?
    @IBOutlet var imageButtons: [UIButton]!
    
    @IBOutlet weak var meatTextField: UITextField!
    @IBOutlet weak var dish1TextField: UITextField!
    @IBOutlet weak var dish2TextField: UITextField!
    @IBOutlet weak var soupTextField: UITextField!
    @IBOutlet weak var uploadButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navtitle
        
        for button in imageButtons {
            button.imageView?.contentMode = .scaleAspectFill
        }
        
        
        updateUploadButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    var button: UIButton?
    @IBAction func selectImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)
        
        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            imagePickerController.dismiss(animated: true, completion: nil)
        }
        
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
        
        button = sender
        present(imagePickerAlertController, animated: true, completion: nil)
        
    }
    
    var selectedImage: [UIImage] = []
    var imageName: [String] = []
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = pickedImage
        }
        
        let uniqueString = NSUUID().uuidString
        
        if let selectedImage = selectedImageFromPicker {
            print("uniqueString \(uniqueString), selectedImage \(selectedImage)")
            print("selectedImage \(selectedImage)")
        }
        
        selectedImage.append(selectedImageFromPicker!)
        imageName.append(uniqueString)
        print("IMAGE ARRAY",selectedImage, imageName)
        
        button!.setImage(selectedImageFromPicker, for: .normal)
        dismiss(animated: true, completion: nil)
        
    }
    
    func updateUploadButtonState() {
        let dish1Text = meatTextField.text ?? ""
        let dish2Text = dish1TextField.text ?? ""
        let dish3Text = dish2TextField.text ?? ""
        let dish4Text = soupTextField.text ?? ""
        uploadButton.isEnabled = !dish1Text.isEmpty && !dish2Text.isEmpty && !dish3Text.isEmpty && !dish4Text.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateUploadButtonState()
    }
    
    @IBAction func uploadButtonPressed(_ sender: UIBarButtonItem) {
        print("ploaded")

        var uploadDic = [String:[String: String]]()
        var number = 0
        for (i, image) in selectedImage.enumerated() {
            let storageRef = Storage.storage().reference().child("Images").child("\(imageName[i]).png")
            if let uploadData = UIImagePNGRepresentation(image) {
                storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in
                    if error != nil {
                        print("ERROR: \(error!.localizedDescription)")
                        return
                    }
                    
                    if let uploadImageUrl = data?.downloadURL()?.absoluteString {
                        print("PHOTO URL: \(uploadImageUrl)")
                        switch i {
                        case 0:
                            uploadDic["meat"] = ["name": self.meatTextField.text!, "pic": uploadImageUrl]
                        case 1:
                            uploadDic["dish1"] = ["name": self.dish1TextField.text!, "pic": uploadImageUrl]
                        case 2:
                            uploadDic["dish2"] = ["name": self.dish2TextField.text!, "pic": uploadImageUrl]
                        case 3:
                            uploadDic["soup"] = ["name": self.soupTextField.text!, "pic": uploadImageUrl]
                        default:
                            break
                        }
                    }
                    number = number + 1
                    if number == 4 {
                        print("new post")
                        DatabaseService.shared.postsReference.child(self.weekdayToEnglish(weekday: self.navtitle!)).setValue(uploadDic)
                    }
                })
            }
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


