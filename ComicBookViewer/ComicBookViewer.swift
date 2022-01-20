//
//  ComicBookViewer.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit

class ComicBookViewer: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Property
    
    var comicBookDirectory: URL? = nil {
        didSet {
            // fetchImages()
        }
    }
    
    var pageIDs: [String]? = nil
    
    var images: [UIImage]? = nil
    
    var index: Int = 0 {
        didSet {
            print(index)
            disableButton()
        }
    }
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: "ComicBookViewer", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Deinitializer
    
    deinit {
        if comicBookDirectory != nil {
            comicBookDirectory = nil
        }
        
        if pageIDs != nil {
            pageIDs = nil
        }
        
        if images != nil {
            images = nil
        }
    }
    
    // MARK: - View Life Cycle Related Method

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        commonInit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("--- ComicBook Viewer viewWillDisappear ---")
        
        if images != nil {
            images = nil
        }
        
        if pageIDs != nil {
            pageIDs = nil
        }
        
        if comicBookDirectory != nil {
            comicBookDirectory = nil
        }
        
        index = 0
    }
    
    // MARK: -
    
    func commonInit() {
        setupButton()
        disableButton()
        setupPageControl()
        changeImage()
        fetchImages()
    }

    // MARK: -
    
    func setupButton() {
        leftButton.setImage(UIImage(named: "LeftButton"), for: .normal)
        rightButton.setImage(UIImage(named: "RightButton"), for: .normal)
    }
    
    func disableButton() {
        if images != nil, leftButton != nil, rightButton != nil {
            switch index {
            case 0:
                if leftButton != nil {
                    leftButton.isEnabled = false
                }
            case (images!.count - 1):
                if rightButton != nil {
                    rightButton.isEnabled = false
                }
            default:
                leftButton.isEnabled = true
                rightButton.isEnabled = true
            }
        }
    }
    
    func setupPageControl() {
        if images != nil {
            print(#function)
            
            pageControl.numberOfPages = images!.count
            pageControl.currentPage = index
            pageControl.currentPageIndicatorTintColor = .gray
            pageControl.pageIndicatorTintColor = .lightGray
            
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
            swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(swipeLeft)

            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRight)
        }
    }
    
    // MARK: - Fetch Images
    
    func fetchImages() {
        if comicBookDirectory != nil, pageIDs != nil {
            if pageIDs!.count > 0 {
                for id in pageIDs! {
                    let imageURL: URL = comicBookDirectory!.appendingPathComponent("\(id).jpg")
                    let image: UIImage? = UIImage(contentsOfFile: imageURL.path)
                    
                    if image != nil {
                        if images == nil {
                            images = []
                        }
                        
                        images!.append(image!)
                    }
                }
            }
        }
    }
    
    // MARK: -
    
    func changeImage() {
        if images != nil {
            imageView.image = images![pageControl.currentPage]
        }
    }

    // MARK: - Page Control Related Action
    
    @IBAction func previousPage(_ sender: Any) {
        increaseIndex(isIncrease: false)
        pageControl.currentPage = index
        changeImage()
    }
    
    @IBAction func nextPage(_ sender: Any) {
        increaseIndex(isIncrease: true)
        pageControl.currentPage = index
        changeImage()
    }
    
    @IBAction func changePage(_ sender: Any) {
        changeImage()
    }
    
    // MARK: -
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                increaseIndex(isIncrease: false)
                pageControl.currentPage = index
                changeImage()
            case .left:
                increaseIndex(isIncrease: true)
                pageControl.currentPage = index
                changeImage()
            default:
                return
            }
        }
    }
    
    // MARK: -
    
    func increaseIndex(isIncrease: Bool) {
        if images == nil {
            return
        }
        
        if isIncrease {
            if index < (images!.count - 1) {
                index += 1
            }
        } else {
            if index > 0 {
                index -= 1
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
