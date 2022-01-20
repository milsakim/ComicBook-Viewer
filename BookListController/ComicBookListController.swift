//
//  BookListController.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit
import CoreData

enum bookListDisplayMode {
    case noCategory
    case noData
    case dataExist
}

class ComicBookListController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var category: Category? = nil {
        didSet {
            print("$$$$$$$$$$")
            reloadTableView()
        }
    }
    
    var comicBooks: [ComicBook]? = nil
    
    var addButton: UIBarButtonItem? = nil
    var editButton: UIBarButtonItem? = nil
    var doneButton: UIBarButtonItem? = nil
    
    var backgroundView: UIView? = nil
    var createComicBookView: CreateComicBookView? = nil
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: "BookListController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
    }
    
    // MARK: - Deinitializer
    
    deinit {
        if category != nil {
            category = nil
        }
        
        if comicBooks != nil {
            comicBooks = nil
        }
        
        if addButton != nil {
            addButton = nil
        }
        
        if editButton != nil {
            editButton = nil
        }
        
        if doneButton != nil {
            doneButton = nil
        }
        
        if backgroundView != nil {
            backgroundView = nil
        }
        
        if createComicBookView != nil {
            createComicBookView = nil
        }
    }
    
    // MARK: - View Life Cycle Related Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: -
    
    func commonInit() {
        setupTableView()
        reloadTableView()
        setupButtons()
    }
    
    // MARK: - Interface Related Methods
    
    func setupButtons() {
        if addButton == nil {
            addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addComicBook))
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
    
    // MARL: - Table View Related Method
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BookCell", bundle: .main), forCellReuseIdentifier: BookCell.reuseIdentifier)
    }
    
    func reloadTableView() {
        if fetchData() {
            tableView.reloadData()
        }
    }
    
    // MARK: - Action
    
    @objc func addComicBook() {
        let rect: CGRect = CGRect(x: splitViewController!.view.frame.width / 4, y: splitViewController!.view.frame.height / 4, width: splitViewController!.view.bounds.width / 2, height: splitViewController!.view.bounds.height / 2)
        
        if createComicBookView == nil, splitViewController != nil {
            createComicBookView = CreateComicBookView(frame: rect)
            createComicBookView?.category = category
            createComicBookView?.delegate = self
        }
        
        if backgroundView == nil {
            let fullScreenRect: CGRect = splitViewController!.view.bounds
            
            backgroundView = UIView(frame: fullScreenRect)
            backgroundView?.alpha = 0.6
            backgroundView?.backgroundColor = .gray
        }
        if createComicBookView != nil, backgroundView != nil, splitViewController != nil {
            let myRect = createComicBookView?.baseView.frame
            print("Rect: \(myRect)")
            createComicBookView!.baseView.frame = rect
            
            splitViewController!.view.addSubview(backgroundView!)
            splitViewController!.view.addSubview(createComicBookView!.baseView)
        } else {
            print("--- splitViewController is nil ---")
        }
        
        print(splitViewController!.view.bounds)
    }
    
    @objc func editTable() {
        
    }

}
