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

class BookListController: UIViewController, CreateComicBookViewDelegate {
    
    // MARK: - Outlet
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    var category: Category? = nil {
        didSet {
            print("--- BookListController category: \(category!.title!) ---")
            reloadTableView()
        }
    }
    
    var comicBooks: [ComicBook]? = nil
    
    var addButton: UIBarButtonItem? = nil
    var editButton: UIBarButtonItem? = nil
    var doneButton: UIBarButtonItem? = nil
    
    var backgroundView: UIView? = nil
    var createComicBookView: CreateComicBookView? = nil
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: "BookListController", bundle: .main)
        
        print("--- BookListController init() ---")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
    }
    
    // MARK: - Deinitialize
    
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
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    // MARK: -
    
    func commonInit() {
        setupTableView()
        reloadTableView()
        setupButtons()
    }
    
    // MARK: - Interface Related Method
    
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

    // MARK: - Fetch Data
    
    func fetchData() -> Bool {
        if category != nil {
            comicBooks = category!.comicBooks?.allObjects as? [ComicBook]
            
            if comicBooks != nil {
                comicBooks!.sort(by: {
                    $0.creationDate! > $1.creationDate!
                })
            }
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Create Comic Book View Delegate Method
    
    func didFinishCreating(title: String, author: String?, thumbnail: UIImage?) {
        print("--- didFinishCreating() ---")
        
        if category != nil {
            CoreDataManager.sharedInstance.addComicBook(category: category!, title: title, author: author, thumbnail: thumbnail)
            reloadTableView()
        }
        
        removeView()
    }
    
    func removeView() {
        print("--- removeView() ---")
        
        backgroundView?.removeFromSuperview()
        createComicBookView?.baseView.removeFromSuperview()
        createComicBookView = nil
    }
    
    func presentImagePicker(controller: UIImagePickerController) {
        present(controller, animated: true, completion: nil)
    }
    
    func dismissImagePicker() {
        dismiss(animated: true, completion: nil)
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
