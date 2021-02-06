//
//  ComicBookViewController.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/01/29.
//

import UIKit

enum DisplayMode {
    case noSelectedCategory
    case noComicBookData
    case comicBookDataExist
}

class ComicBookViewController: UIViewController {

    // MARK: - Outlet
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var comicBookTableView: UITableView!
    
    // MARK: - Property
    
    var category: Category? = nil
    
    var comicBooks: [ComicBook]? = nil
    
    var displayMode: DisplayMode = DisplayMode.noSelectedCategory
    
    var addComicBookButton: UIBarButtonItem? = nil
    var doneEdittingButton: UIBarButtonItem? = nil
    var editButton: UIBarButtonItem? = nil
    
    // MARK: - Deinitializer
    
    deinit {
        if category != nil {
            category = nil
        }
        
        if addComicBookButton != nil {
            addComicBookButton = nil
        }
        
        if doneEdittingButton != nil {
            doneEdittingButton = nil
        }
        
        if editButton != nil {
            editButton = nil
        }
        
        print("--- ComicBookViewController deinit ---")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupComicBookTableView()
        setupInterface()
    }
    
    // MARK: - Setup Comic Book Table View
    
    func setupComicBookTableView() {
        comicBookTableView.dataSource = self
        comicBookTableView.delegate = self
        comicBookTableView.register(UINib(nibName: "ComicBookTableViewCell", bundle: nil), forCellReuseIdentifier: ComicBookTableViewCell.identifier)
    }
    
    // MARK: - Setup Interface
    
    func setupInterface() {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        if addComicBookButton == nil {
            addComicBookButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewComicBook))
        }
        
        if doneEdittingButton == nil {
            doneEdittingButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editComicBookTableView))
        }
        
        if editButton == nil {
            editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editComicBookTableView))
        }
        
        
        if comicBookTableView.isEditing {
            navigationItem.setRightBarButtonItems([doneEdittingButton!, addComicBookButton!], animated: true)
        } else {
            navigationItem.setRightBarButtonItems([editButton!, addComicBookButton!], animated: true)
        }
    }
    
    // MARK: - Action
    
    @objc func addNewComicBook() {
        
    }
    
    @objc func editComicBookTableView() {
        if comicBookTableView.isEditing {
            comicBookTableView.isEditing = false
            setupNavigationBar()
        } else {
            comicBookTableView.isEditing = true
            setupNavigationBar()
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
