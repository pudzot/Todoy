//
//  CategoryViewController.swift
//  Todoy
//
//  Created by Damian Piszcz on 01/12/2020.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add new", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textfield.text!
            
            self.categories.append(newCategory)
            
            self.saveCategory()
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Shopping"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            print(" error save category")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategory() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
             categories = try context.fetch(request)
        } catch  {
            print("error load category \(error)")
        }
    }
    

    // MARK: - Table view data source

}
