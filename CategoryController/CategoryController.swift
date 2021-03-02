//
//  CategoryController.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit
import CoreData

enum CategoryControllerDisplayMode {
    case noCategory
    case categoryExist
}

class CategoryController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            print("--- CategoryController messageLabel didSet ---")
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            print("--- CategoryController tableView didSet ---")
        }
    }
    
    // MARK: - Property
    
    var categories: [Category]? = nil
    
    var displayMode: CategoryControllerDisplayMode = .noCategory
    
    var addButton: UIBarButtonItem? = nil
    var editButton: UIBarButtonItem? = nil
    var doneButton: UIBarButtonItem? = nil
    
    // MARK: -
    
    init() {
        super.init(nibName: "CategoryController", bundle: .main)
        
        print("--- CategoryController init ---")
        
        if tableView == nil {
            print("--- Category controller table view nil ---")
        } else {
            print("--- Category controller table view not nil ---")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
    }
    
    // MARK: - Deinitialize
    
    deinit {
        if categories != nil {
            categories = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("--- awakeFromNib() ---")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("--- CategoryController viewDidLoad ---")
        
        commonInit()
    }
    
    // MARK: -
    
    func commonInit() {
        setupTableView()
        setupButtons()
    }
    
    // MARK: - Interface Related Method
    
    func setupButtons() {
        if addButton == nil {
            addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
        }
        
        if editButton == nil {
            editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTable))
        }
        
        if doneButton == nil {
            doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTable))
        }
        
        if tableView.isEditing {
            navigationItem.setRightBarButtonItems([doneButton!, addButton!], animated: true)
        } else {
            navigationItem.setRightBarButtonItems([editButton!, addButton!], animated: true)
        }
    }
    
    // MARK: - Action
    
    @objc func addCategory() {
        let alertController: UIAlertController = UIAlertController(title: "New Category", message: nil, preferredStyle: .alert)
        
        let create: UIAlertAction = UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let title: String = alertController.textFields?[0].text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                return
            }
            
            if title.isEmpty {
                // when title is 
            } else {
                guard let category: Category = CoreDataManager.sharedInstance.addCategory(title: title) else {
                    return
                }
                
                if self.categories != nil {
                    self.categories!.append(category)
                    self.tableView.reloadData()
                } else {
                    self.reloadTable()
                }
            }
        })
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "New Category Name"
        })
        alertController.addAction(create)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func editTable() {
        if tableView.isEditing {
            tableView.isEditing = false
            setupButtons()
        } else {
            tableView.isEditing = true
            setupButtons()
        }
    }
    
    // MARK: - Table View Related Method
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CategoryCell", bundle: .main), forCellReuseIdentifier: CategoryCell.reuseIdentifier)
        
        reloadTable()
    }
    
    func reloadTable() {
        if fetchData() {
            tableView.reloadData()
        }
    }
    
    func deleteCategory(index: Int) {
        if categories != nil, index < categories!.count, index >= 0 {
            let category: Category = categories![index]
            
            print("--- CategoryController deleted category: \(category.title) ---")
            
            if CoreDataManager.sharedInstance.deleteCategory(category: category) {
                categories!.remove(at: index)
                
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Fetch Data
    
    func fetchData() -> Bool {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest = Category.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(ComicBook.creationDate), ascending: true)]
        
        // Perform Fetch Request
        do {
            categories = try CoreDataManager.sharedInstance.managedObjectContext?.fetch(fetchRequest)
           
            return true
        } catch {
            return false
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
