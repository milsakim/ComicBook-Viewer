//
//  ComicBookViewerController.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/23.
//

import UIKit

class ComicBookViewerController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var baseView: UIView!
    
    // MARK: - Property
    
    var pageViewController: UIPageViewController?
    
    var pageIDs: [String]?
    var comicBookDirectory: URL?
    
    var index: Int?
    
    var isTapped: Bool = true
    
    // MARK: - Deinitailizer
    
    deinit {
        if pageViewController != nil {
            pageViewController = nil
        }
        
        if pageIDs != nil {
            pageIDs = nil
        }
        
        if comicBookDirectory != nil {
            comicBookDirectory = nil
        }
        
        print("--- ComicBookViewerController deinit ---")
    }
    
    // MARK: - View Life Cycle Related Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        print(baseView.bounds)
        
        commonInit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: -
    
    func commonInit() {
        setupButtons()
        setupPageViewController()
    }
    
    // MARK: - Buttons Related Methods
    
    func setupButtons() {
        leftButton.setImage(UIImage(named: "LeftButton"), for: .normal)
        rightButton.setImage(UIImage(named: "RightButton"), for: .normal)
    }
    
    func hideButtons() {
        if isTapped {
            leftButton.isHidden = false
            rightButton.isHidden = false
        } else {
            leftButton.isHidden = true
            rightButton.isHidden = true
        }
    }
    
    // MARK: -
    
    func setupPageViewController() {
        if pageViewController == nil {
            pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }
        
        if pageViewController != nil {
            pageViewController!.dataSource = self
            pageViewController!.delegate = self
            
            pageViewController!.view.frame = baseView.frame
            pageViewController!.view.backgroundColor = .black
            
            // pageViewController!.didMove(toParent: self)
            
            /*
            if index != nil {
                if let startViewController: PageView = pageViewAtIndex(at: index!) {
                    pageViewController!.setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
                }
            } else {
                if let startViewController: PageView = pageViewAtIndex(at: 0) {
                    pageViewController!.setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
                }
            }
            */
            
            if index != nil {
                if let startViewController: PageViewController = pageViewAtIndex(at: index!) {
                    pageViewController!.setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
                }
            } else {
                if let startViewController: PageViewController = pageViewAtIndex(at: 0) {
                    pageViewController!.setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
                }
            }
            
            addChild(pageViewController!)
            view.addSubview(pageViewController!.view)
        }
    }

    // MARK: -
    
    func pageViewAtIndex(at index: Int) -> PageViewController? {
        if pageIDs != nil {
            if index >= 0, index < pageIDs!.count {
                /*
                let pageView: PageView = PageView()
                
                pageView.id = pageIDs![index]
                pageView.imageURL = createImageURL(of: pageIDs![index])
                */
                
                let pageView: PageViewController = PageViewController()
                pageView.id = pageIDs![index]
                pageView.imageURL = createImageURL(of: pageIDs![index])
                pageView.baseViewSize = baseView.bounds
                
                self.index = index
                
                return pageView
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    func createImageURL(of id: String) -> URL? {
        if comicBookDirectory != nil {
            return comicBookDirectory!.appendingPathComponent("\(id).jpg")
        }
        
        return nil
    }
    
    // MARL: - Handling Gestures Related Methods
    
    @IBAction func handleTap(_ sender: Any) {
        print(#function)
        
        if isTapped {
            isTapped = false
        } else {
            isTapped = true
        }
        
        UIView.animate(withDuration: 2.0, animations: {
            self.hideButtons()
            self.hideNavigation()
        }, completion: nil)
    }
    
    func hideNavigation() {
        if navigationController != nil {
            if isTapped {
                navigationController!.navigationBar.isHidden = false
            } else {
                navigationController!.navigationBar.isHidden = true
            }
        }
    }
    
    @IBAction func handlePinch(_ sender: Any) {
        /*
        print(#function)
        
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
        */
    }
    
    // MARK: - Actions
    
    @IBAction func previousPage(_ sender: Any) {
        print(#function)
        
        if pageViewController != nil, index != nil {
            if (index! - 1) >= 0 {
                pageViewController!.setViewControllers([pageViewAtIndex(at: index! - 1)!], direction: .reverse, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        print(#function)
        
        if pageViewController != nil, index != nil {
            if (index! + 1) < pageIDs!.count {
                pageViewController!.setViewControllers([pageViewAtIndex(at: index! + 1)!], direction: .forward, animated: true, completion: nil)
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
