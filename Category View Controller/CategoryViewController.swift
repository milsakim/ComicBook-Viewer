//
//  CategoryViewController.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/01/31.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController {
    
    // MARK: - Outlet

    @IBOutlet var categoryTableView: UITableView!
    
    // MARK: - Property
    
    var categories: [Category]? = nil
    
    var addCategoryButton: UIBarButtonItem? = nil
    var doneEditingButton: UIBarButtonItem? = nil
    var editButton: UIBarButtonItem? = nil
   
    // MARK: - Deinit
    
    deinit {
        if categories != nil {
            categories = nil
        }
        
        if addCategoryButton != nil {
            addCategoryButton = nil
        }
        
        if doneEditingButton != nil {
            doneEditingButton = nil
        }
        
        if editButton != nil {
            editButton = nil
        }
        
        print("--- CategoryViewController deinit ---")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCategoryTableView()
        setupInterface()
        
        if !fetchCategories() {
            print("--- fetch categories failed ---")
        }
    }
    
    // MARK: - Setup Category Table View
    
    func setupCategoryTableView() {
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
    
    // MARK: - Setup Interface
    
    func setupInterface() {
        setupNavigationBarItem()
    }
    
    func setupNavigationBarItem() {
        if addCategoryButton == nil {
            addCategoryButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCategory))
        }
        
        if doneEditingButton == nil {
            doneEditingButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editCategoryTableView))
        }
        
        if editButton == nil {
            editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editCategoryTableView))
        }
        
        if categoryTableView.isEditing {
            navigationItem.setRightBarButtonItems([doneEditingButton!, addCategoryButton!], animated: true)
        } else {
            navigationItem.setRightBarButtonItems([editButton!, addCategoryButton!], animated: true)
        }
    }
    
    // MARK: - Action
    
    @objc func addNewCategory() {
        // Create Alert Controller
        let alertController: UIAlertController = UIAlertController(title: "New Category", message: "Enter title for new category", preferredStyle: .alert)
        
        // Create Alert Actions
        let createAction: UIAlertAction = UIAlertAction(title: "Create", style: .default) { _ in
            if alertController.textFields?[0].text != nil {
                let newCategoryID: UUID? = CoreDataManager.sharedInstance.addNewCategory(title: alertController.textFields![0].text!)
                
                print("--- New Category ID: \(newCategoryID?.uuidString) ---")
                
                if self.fetchCategories() {
                    self.categoryTableView.reloadData()
                    
                    let bottomIndex: IndexPath = IndexPath(row: (self.categories!.count - 1), section: 0)
                    self.categoryTableView.selectRow(at: bottomIndex, animated: true, scrollPosition: .bottom)
                }
            }
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Configuer Alert Controller
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Category Title"
        })
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func editCategoryTableView() {
        if categoryTableView.isEditing {
            categoryTableView.isEditing = false
            
            setupNavigationBarItem()
        } else {
            categoryTableView.isEditing = true
            
            setupNavigationBarItem()
        }
    }
    
    // MARK: - Fetch Data
    
    func fetchCategories() -> Bool {
        print("--- fetchCategories() ---")
        
        // Create Fetch Request
        let fetchRequest: NSFetchRequest = Category.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(ComicBook.creationDate), ascending: true)]
        
        // Perform Fetch Request
        do {
            categories = try CoreDataManager.sharedInstance.managedObjectContext?.fetch(fetchRequest)
            
            print("--- categories: \(categories) ---")
            
            return true
        } catch {
            return false
        }
    }
    
    // MARK: -
    
    func deleteCategory(index: Int) {
        if categories != nil {
            if index < categories!.count {
                print("--- Category to Delete: \(categories![index].title!) ---")
                
                var categoryToDelete: Category? = categories![index]
                
                if CoreDataManager.sharedInstance.deleteCategory(category: categoryToDelete) {
                    categories!.remove(at: index)
                    categoryTableView.reloadData()
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
