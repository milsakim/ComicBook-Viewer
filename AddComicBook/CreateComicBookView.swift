//
//  CreateComicBookView.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/16.
//

import UIKit

class CreateComicBookView: UIView {
    
    // MARK: - Outlet
    
    @IBOutlet var baseView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var thumnailButton: UIButton!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    
    // MARK: - Property
    
    weak var delegate: CreateComicBookViewDelegate? = nil
    
    var thumbnailImage: UIImage? = nil {
        didSet {
            updateThumbnailImageView()
        }
    }
    
    var imagePickerController: UIImagePickerController? = nil
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("--- CreateComicBookView init ---")
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        print("--- CreateComicBookView init(coder:) ---")
        
        commonInit()
    }
    
    // MARK: -
    
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
        
        print("--- CreateComicBookView awakerFromNib ---")
        
        commonInit()
    }
    
    // MARK: -
    
    private func commonInit() {
        print("--- CreateComicBookView commonInit ---")
        Bundle.main.loadNibNamed("CreateComicBookView", owner: self, options: nil)
        
        if self.baseView != nil {
            // baseView.frame = self.bounds
            baseView.backgroundColor = .white
        }
        
        print("--- bounds: \(self.bounds) ---")
        
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
    
    // MARK: -
    
    func createThumbnail(url: URL) {
        let frameImage: UIImage? = UIImage(named: "ThumbnailFrame")
        let selectedImage: UIImage? = UIImage(contentsOfFile: url.path)
        
        if frameImage != nil, selectedImage != nil {
            let rect: CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: frameImage!.size)
            
            UIGraphicsBeginImageContextWithOptions(frameImage!.size, false, frameImage!.scale)
            
            selectedImage!.draw(in: rect)
            frameImage!.draw(in: rect)
            
            thumbnailImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
        }
    }
    
    func updateThumbnailImageView() {
        if thumbnailImage != nil {
            thumbnailImageView.image = thumbnailImage
        } else {
            thumbnailImageView.image = UIImage(named: "NoSelectedThumbnail")
        }
    }
    
    // MARK: - Action
    
    @IBAction func cancel(_ sender: Any) {
        print(#function)
        
        guard let delegate = self.delegate else {
            return
        }
        
        thumbnailImage = nil
        updateThumbnailImageView()
        
        delegate.removeView()
    }
    
    @IBAction func create(_ sender: Any) {
        print(#function)
        
        guard let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        let author = authorTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.didFinishCreating(title: title, author: author, thumbnail: thumbnailImage)
    }
    
    @IBAction func importImage(_ sender: Any) {
        print(#function)
        
        if imagePickerController == nil {
            imagePickerController = UIImagePickerController()
            imagePickerController!.delegate = self
            imagePickerController!.sourceType = .photoLibrary
        }
        
        if imagePickerController != nil, delegate != nil {
            delegate!.presentImagePicker(controller: imagePickerController!)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

protocol CreateComicBookViewDelegate: AnyObject {
    
    func didFinishCreating(title: String, author: String?, thumbnail: UIImage?)
    
    func removeView()
    
    func presentImagePicker(controller: UIImagePickerController)
    
    func dismissImagePicker()
    
}
