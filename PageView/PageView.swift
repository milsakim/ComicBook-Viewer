//
//  PageView.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/23.
//

import UIKit

class PageView: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Property
    
    var id: String?
    
    var imageURL: URL?
    
    // MARK: - Initializers

    init() {
        super.init(nibName: "PageView", bundle: .main)
        
        print("--- PageView init() ---")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    
    deinit {
        print("--- PageView \(id!) deinit ---")
        
        if id != nil {
            id = nil
        }
        
        if imageURL != nil {
            imageURL = nil
        }
    }

    // MARK: - View Life Cycle Related Method
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("--- PageView \(id!) viewDidLoad() ---")
        
        setupImageView()
    }
    
    // MARK: - Image View Related Methods
    
    func setupImageView() {
        if imageURL != nil {
            let fileManager: FileManager = FileManager.default
            
            if fileManager.fileExists(atPath: imageURL!.path) {
                imageView.image = UIImage(contentsOfFile: imageURL!.path)
            }
        }
    }
    
    // MARK: - Handling Gesture Related Methods
    
    @IBAction func handlePinch(_ sender: Any) {
        print("--- handlePinch ---")
        guard let gestureRecognizer = sender as? UIPinchGestureRecognizer else {
            return
        }
        
        guard gestureRecognizer.view != nil else {
            return
        }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            gestureRecognizer.view!.transform = (gestureRecognizer.view!.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))
            gestureRecognizer.scale = 1.0
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
