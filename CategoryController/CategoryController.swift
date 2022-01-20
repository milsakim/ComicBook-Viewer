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
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    var categories: [Category]? = nil
    
    var displayMode: CategoryControllerDisplayMode = .noCategory
    
    var addButton: UIBarButtonItem? = nil
    var editButton: UIBarButtonItem? = nil
    var doneButton: UIBarButtonItem? = nil
    
    // MARK: -
    
    init() {
        super.init(nibName: "CategoryController", bundle: .main)
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
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
    }
    
    // MARK: - Common Initialize
    
    func commonInit() {
        setupTableView()
        setupButtons()
    }

}
