//
//  PageViewController.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/30.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    var id: String?
    var imageURL: URL?
    var image: UIImage?
    var imageView: UIImageView?
    var baseViewSize: CGRect?
    
    // MARK: - Initializers

    init() {
        super.init(nibName: "PageViewController", bundle: .main)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    
    deinit {
        if id != nil {
            id = nil
        }
        
        if imageURL != nil {
            imageURL = nil
        }
        
        if imageView != nil {
            imageView = nil
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit(size: baseViewSize!.size)
    }

    // MARK: - Commin Init Related Methods
    
    func commonInit(size: CGSize) {
        setupScrollView(size: size)
        setupImageView(size: size)
    }

}
