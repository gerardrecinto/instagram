//
//  PictureViewController.swift
//  instagram
//
//  Created by Gerard Recinto on 3/13/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit
import Parse
class PictureViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var photoLabel: UILabel!
  @IBOutlet weak var captionTextField: UITextField!

  @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  @IBAction func findImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
    self.present(imagePicker, animated: true, completion: nil)
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    guard let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
      fatalError("Error when picking photo")
    }
    self.captionTextField.text = ""
    self.photoLabel.isHidden = true
    self.posterImageView.image = originalImage
    self.captionTextField.textColor = .black
    dismiss(animated: true, completion: nil)

  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.photoLabel.isHidden = false
  }
  @IBAction func onSubmitButton(_ sender: Any) {
    let imagePost = resize(image: self.posterImageView.image!, newSize: CGSize(width: 600, height: 600))
    let caption = self.captionTextField.text
    Post.postUserImage(image: imagePost, withCaption: caption) { (
      success: Bool,
      error: Error?) in
      if success {
        self.tabBarController?.selectedIndex = 0
      } else {
        print(error?.localizedDescription)
      }
    }
    self.posterImageView.image = nil
    self.photoLabel.isHidden = false
    self.captionTextField.text = "add a caption"
    self.captionTextField.textColor = .black
  }
  func resize(image: UIImage, newSize: CGSize) -> UIImage {
    let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
  resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
  resizeImageView.image = image
  
  UIGraphicsBeginImageContext(resizeImageView.frame.size)
  resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
  let newImage = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()
  return newImage!
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
