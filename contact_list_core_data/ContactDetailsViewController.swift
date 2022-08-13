//
//  ContactDetailsViewController.swift
//  contact_list_core_data
//
//  Created by Cenk Bahadır Çark on 12.08.2022.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    @IBOutlet weak var personNameLabel: UILabel! // for default view 
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var kisi : Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let k = kisi{
            personNameLabel.text = k.kisi_ad
            phoneNumberLabel.text = k.kisi_tel
        }
    }
    


}
