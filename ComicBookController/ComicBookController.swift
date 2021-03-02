//
//  ComicBookController.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit
import UniformTypeIdentifiers

enum ComicBookControllerDisplayMode {
    
    case noComicBook
    case noData
    case dataExist
    
}

class ComicBookController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    
    var comicBook: ComicBook? = nil {
        didSet {
            print("%%%%%%%%%%%%%%%%%%")
            setupTitle()
            updateDisplayMode()
            reloadCollectionView()
            setupComicBookDirectory()
            // fetchImages()
        }
    }
    
    var comicBookDirectory: URL? = nil
    
    var displayMode: ComicBookControllerDisplayMode = .noComicBook {
        didSet {
            displayButton()
        }
    }
    
    var documentPickerViewController: UIDocumentPickerViewController? = nil
    
    var pages: [Page]? = nil {
        didSet {
            updateDisplayMode()
            // fetchImages()
        }
    }
    
    var addButton: UIBarButtonItem? = nil
    var editButton: UIBarButtonItem? = nil
    var doneButton: UIBarButtonItem? = nil
    
    var viewer: ComicBookViewer? = nil
    var viewer2: ComicBookViewerController? = nil
    
    var images: [UIImage]? = nil
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: "ComicBookController", bundle: .main)
        
        print("--- ComicBookController init() ---")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitialize
    
    deinit {
        print(#function)
        
        if comicBook != nil {
            comicBook = nil
        }
        
        if comicBookDirectory != nil {
            comicBookDirectory = nil
        }
        
        if documentPickerViewController != nil {
            documentPickerViewController = nil
        }
        
        if pages != nil {
            pages = nil
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
        
        if viewer != nil {
            viewer = nil
        }
        
        if viewer2 != nil {
            viewer2 = nil
        }
    }
    
    // MARK: - View Life Cycle Related Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("--- ComicBookController viewDidLoad() ---")
        
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("--- ComicBookController viewWillAppear() ---")
        
        if viewer2 != nil {
            viewer2 = nil
        }
    }

    // MARK: -
    
    func commonInit() {
        print("--- ComicBookController commonInit() ---")
        
        setupTitle()
        setupButton()
        displayButton()
        setupCollectionView()
    }
    
    // MARK: -
    func setupTitle() {
        if comicBook != nil {
            title = comicBook!.title
        } else {
            title = ""
        }
    }
    
    func setupButton() {
        print("--- ComicBookController setupButton() ---")
        
        if addButton == nil {
            addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPage))
        }
        
        if editButton == nil {
            editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editCollectionView))
        }
        
        if doneButton == nil {
            doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editCollectionView))
        }
        
        if collectionView.isEditing {
            navigationItem.setRightBarButtonItems([doneButton!, addButton!], animated: true)
        } else {
            navigationItem.setRightBarButtonItems([editButton!, addButton!], animated: true)
        }
    }
    
    func displayButton() {
        print("--- ComicBookController displayButton() ---")
        
        switch displayMode {
        case .noComicBook:
            if addButton != nil, editButton != nil {
                addButton!.isEnabled = false
                editButton!.isEnabled = false
            }
        case .noData:
            if addButton != nil, editButton != nil {
                addButton!.isEnabled = true
                editButton!.isEnabled = false
            }
        case .dataExist:
            if addButton != nil, editButton != nil {
                addButton!.isEnabled = true
                editButton!.isEnabled = true
            }
        }
    }
    
    // MARK: -
    
    func fetchData() -> Bool {
        if comicBook != nil {
            pages = comicBook!.pages?.allObjects as? [Page]
            
            if pages != nil {
                pages!.sort(by: {
                    $0.index < $1.index
                })
            }
            return true
        } else {
            return false
        }
    }
    
    func fetchImages() {
        images = nil
        
        if pages != nil {
            if images == nil {
                images = []
            }
            
            if comicBookDirectory != nil {
                for page in pages! {
                    let imageURL: URL = comicBookDirectory!.appendingPathComponent("\(page.id!).jpg")
                    let image: UIImage? = UIImage(contentsOfFile: imageURL.path)
                    
                    if image != nil {
                        print("$$$ image $$$")
                        images!.append(image!)
                    } else {
                        print("$$$ image no no $$$")
                    }
                }
            }
        }
    }
    
    // MARK: - Collection View Related Methods
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PageCell", bundle: .main), forCellWithReuseIdentifier: "PageCell")
    }
    
    func reloadCollectionView() {
        if fetchData() {
            collectionView.reloadData()
        } else {
            pages = nil
            collectionView.reloadData()
        }
    }

    // MARK: -
    
    func updateDisplayMode() {
        if comicBook == nil {
            displayMode = .noComicBook
        } else if comicBook != nil, pages == nil {
            displayMode = .noData
        } else if comicBook != nil, pages != nil {
            displayMode =   .dataExist
        }
    }
    
    // MARK: - Action
    
    @objc func addPage() {
        if documentPickerViewController == nil {
//            documentPickerViewController = UIDocumentPickerViewController(documentTypes: [UTType.image.identifier], in: .import)
            documentPickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.image])
        }
        
        documentPickerViewController!.delegate = self
        documentPickerViewController!.allowsMultipleSelection = true
        
        present(documentPickerViewController!, animated: true, completion: nil)
    }
    
    @objc func editCollectionView() {
        
    }
    
    // MARK: -
    
    func setupComicBookDirectory() {
        if comicBook != nil {
            let fileManager: FileManager = FileManager.default
            let urls: [URL] = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            
            if urls.count > 0 {
                let documentDirectory: URL = urls[0]
                let defaultDirectory: URL = documentDirectory.appendingPathComponent(DirectoryPath.defaultDirectory.rawValue)
                
                comicBookDirectory = defaultDirectory.appendingPathComponent(comicBook!.id!.uuidString)
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
