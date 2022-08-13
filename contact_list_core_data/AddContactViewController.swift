//
//  AddContactViewController.swift
//  contact_list_core_data
//
//  Created by Cenk Bahadır Çark on 12.08.2022.
//

import UIKit

class AddContactViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var phoneNumberText: UITextField!
    @IBOutlet weak var personNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addButton(_ sender: Any) {
        
        if let name = personNameText.text, let phone = phoneNumberText.text{
            
            let kisi = Kisiler(context: context)
            kisi.kisi_ad = name
            kisi.kisi_tel = phone
            
            appDelegate.saveContext()
            _ = navigationController?.popToRootViewController(animated: true)
            
        }
        
        
        
    }
    
}
