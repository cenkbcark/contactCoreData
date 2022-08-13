//
//  ViewController.swift
//  contact_list_core_data
//
//  Created by Cenk Bahadır Çark on 12.08.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    var kisilerListe = [Kisiler]()
    var searching = false
    var searchWord : String?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if searching{
            searchPerson(kisiAd: searchWord!)
        }else{
            getAllPerson()
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        
        if segue.identifier == "toDetails"{
            let gidilecekVC = segue.destination as! ContactDetailsViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        if segue.identifier == "toUpdate"{
            let gidilecekVC = segue.destination as! UpdateContactViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
    }
    
    func getAllPerson() {
        do{
            kisilerListe = try context.fetch(Kisiler.fetchRequest())
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func searchPerson(kisiAd: String) {
        
        let fetchRequest : NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "kisi_ad CONTAINS %@", kisiAd)
        
        do{
            kisilerListe = try context.fetch(fetchRequest)
        }catch{
            print(error.localizedDescription)
        }
    }


}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kisi = kisilerListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath) as! PersonTableViewCell
        
        cell.personNameLabel.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetails", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, boolValue in
            print("Sil tiklandi")
            
            let kisi = self.kisilerListe[indexPath.row]
            self.context.delete(kisi)
            appDelegate.saveContext()
            if self.searching{
                self.searchPerson(kisiAd: self.searchWord!)
            }else{
                self.getAllPerson()
            }
            self.tableView.reloadData()
            
            
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { action, view, boolValue in
            print("Edit tiklandi")
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
    }
        
        
    }
      
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
        
        searchWord = searchText
        
        
        if searchText == "" {
            searching = false
            getAllPerson()
        }else{
            searching = true
            searchPerson(kisiAd: searchWord!)
        }
        self.tableView.reloadData()
        
        
        
        
    }
}

