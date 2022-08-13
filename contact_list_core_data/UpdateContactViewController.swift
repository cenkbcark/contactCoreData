//
//  UpdateContactViewController.swift
//  contact_list_core_data
//
//  Created by Cenk Bahadır Çark on 12.08.2022.
//

import UIKit

class UpdateContactViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var phoneNumberText: UITextField!
    @IBOutlet weak var personNameText: UITextField!
    
    var kisi : Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = kisi{
            personNameText.text = k.kisi_ad
            phoneNumberText.text = k.kisi_tel
        }

        
    }
    

    @IBAction func updateButton(_ sender: Any) {
        
        if let k = kisi, let name = personNameText.text, let phone = phoneNumberText.text{
            
            k.kisi_ad = name
            k.kisi_tel = phone
            
            appDelegate.saveContext()
            _ = navigationController?.popToRootViewController(animated: true)
            
        }
        
    }
    

}
