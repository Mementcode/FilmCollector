//
//  FilmViewController.swift
//  FilmCollector
//
//  Created by callum brennan on 14/04/2017.
//  Copyright © 2017 callum brennan Mementcode. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var addUpdateButton: UIButton!

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var filmImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var films : Film? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    imagePicker.delegate = self
        
        
        // This if loop says if we are adding a new film (true) hide the delete button, but if we are looking into an already created film then change the add button to update.
        
        if films != nil { //
        
         filmImageView.image = UIImage(data: films!.image as! Data )
            titleTextField.text = films!.title
            
            addUpdateButton.setTitle("Update", for: .normal) // changes the "add button" to "update"
        } else {
            
            deleteButton.isHidden = true // hides "delete" button
        }
        
        
    }


    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary // code to get to images from photo libary
        
        present(imagePicker, animated: true, completion: nil) // presents animation of photo libary on screen
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        filmImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
}
    
   
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera // code to go to camera
        
        present(imagePicker, animated: true, completion: nil) // presents animation of photo libary on screen

    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        
        if films != nil {
            
            films!.title = titleTextField.text
            films!.image = UIImagePNGRepresentation(filmImageView.image!) as NSData?
            
        } else {
            
            // puts a chosen image and title into CoreData, coverts to a PNGR file
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let films = Film(context: context)
            films.title = titleTextField.text
            films.image = UIImagePNGRepresentation(filmImageView.image!) as NSData?
            
        }
    
            
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func DeleteTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(films!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)

        
        
    }
}
