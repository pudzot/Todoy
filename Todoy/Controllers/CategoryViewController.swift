//
//  CategoryViewController.swift
//  Todoy
//
//  Created by Damian Piszcz on 01/12/2020.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories yet"

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add ", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textfield.text!
            
           
            
            self.save(category: newCategory)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Shopping"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(" error save category")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategory() {
        
        
        categories = realm.objects(Category.self)
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        
//        do {
//             categories = try context.fetch(request)
//        } catch  {
//            print("error load category \(error)")
//        }
//        
          tableView.reloadData()
    }
    

    // MARK: - Table view data source

}
