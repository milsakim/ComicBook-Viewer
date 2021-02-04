//
//  CategoryViewController.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/01/31.
//

import UIKit

class CategoryViewController: UIViewController {
    
    // MARK: - Outlet

    @IBOutlet var categoryTableView: UITableView!
    
    // MARK: - Property
    
    var categories: [Category]? = nil
    
    var addCategoryButton: UIBarButtonItem? = nil
   
    // MARK: - Deinit
    
    deinit {
        if categories != nil {
            categories = nil
        }
        
        if addCategoryButton != nil {
            addCategoryButton = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Set Up Interface
    
    func setUpInterface() {
        
    }
    
    func setUpNavigationBarItem() {
        if addCategoryButton == nil {
            addCategoryButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCategory))
        }
    }
    
    // MARK: - Action
    
    @objc func addNewCategory() {
        // Create Alert Controller
        let alertController: UIAlertController = UIAlertController(title: "New Category", message: "Enter title for new category", preferredStyle: .alert)
        
        // Create Alert Actions
        let createAction: UIAlertAction = UIAlertAction(title: "Create", style: .default) { _ in
            if alertController.textFields?[0].text != nil {
                
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
