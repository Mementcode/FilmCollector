//
//  FilmViewController.swift
//  FilmCollector
//
//  Created by callum brennan on 14/04/2017.
//  Copyright © 2017 callum brennan Mementcode. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var filmImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    imagePicker.delegate = self
        
    }
   
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        filmImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
}
    
   
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
        // puts a chosen image and title into CoreData, coverts to a PNGR file
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let film = Film(context: context)
        film.title = titleTextField.text
        film.image = UIImagePNGRepresentation(filmImageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
}
