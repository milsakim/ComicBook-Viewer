//
//  CreateComicBookView.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/16.
//

import UIKit

class CreateComicBookView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet var baseView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var thumnailButton: UIButton!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    
    // MARK: - Properties
    
    weak var delegate: CreateComicBookViewDelegate?
    
    var category: Category?
    
    var thumbnailImage: UIImage? = nil {
        didSet {
            updateThumbnailImageView()
        }
    }
    
    var imagePickerController: UIImagePickerController? = nil
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    // MARK: - Deinitializer
    
    deinit {
        print(#function)
        
        if delegate != nil {
            delegate = nil
        }
        
        if thumbnailImage != nil {
            thumbnailImage = nil
        }
        
        if imagePickerController != nil {
            imagePickerController = nil
        }
    }
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        commonInit()
    }
    
    // MARK: - Common Initialize
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CreateComicBookView", owner: self, options: nil)
        
        if self.baseView != nil {
            // baseView.frame = self.bounds
            baseView.backgroundColor = .white
        }
        
        updateThumbnailImageView()
        /*
        guard let loadedNib = Bundle.main.loadNibNamed("CreateComicBookView", owner: self, options: nil), let view = loadedNib.first as? UIView else {
            print("--- CreateComicBookView commonInit return ---")
            return
        }
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .yellow
        
        print("--- view bounds: \(view.bounds) ---")
        
        self.backgroundColor = .cyan
        self.addSubview(view)
        */
        
        /*
        guard let loadedNib = Bundle.main.loadNibNamed("CreateComicBookView", owner: self, options: nil) else {
            return
        }
        
        topLevelView = loadedNib.first as? UIView
        
        if topLevelView != nil {
            topLevelView!.frame = self.bounds
            topLevelView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            topLevelView!.backgroundColor = .cyan
            
            print("topLevelView's frame: \(topLevelView!.frame)")
            print("topLevelView's subviews: \(topLevelView!.subviews)")
            
            addSubview(topLevelView!)
        }
        */
    }
    
}

protocol CreateComicBookViewDelegate: AnyObject {
    
    func didFinishCreatingComicBook(success: Bool)
    
    func removeView()
    
    func presentImagePicker(controller: UIImagePickerController)
    
    func dismissImagePicker()
    
}
