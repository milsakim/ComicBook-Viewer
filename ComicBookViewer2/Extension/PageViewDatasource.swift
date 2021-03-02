//
//  PageViewDatasource.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/23.
//

import UIKit

extension ComicBookViewerController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("--- Page View Controller Datasource pageViewController(_:viewControllerBefore:) ---")
        
        if pageIDs != nil {
            let pageViewBefore: PageView = viewController as! PageView
            let indexBefore: Int? = pageIDs!.firstIndex(of: pageViewBefore.id!)
            
            if indexBefore != nil {
                return pageViewAtIndex(at: indexBefore! - 1)
            }
            
            if index != nil {
                index! -= 1
            }
        }

        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("--- Page View Controller Datasource pageViewController(_:viewControllerAfter:) ---")
        
        if pageIDs != nil {
            let pageViewAfter: PageView = viewController as! PageView
            let indexAfter: Int? = pageIDs!.firstIndex(of: pageViewAfter.id!)
            
            if indexAfter != nil {
                return pageViewAtIndex(at: indexAfter! + 1)
            }
            
            if index != nil {
                index! += 1
            }
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        print("--- Page View Controller Datasource presentationCount(for:) ---")
        
        if pageIDs == nil {
            return 0
        }
        
        return pageIDs!.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        print("--- Page View Controller Datasource presentationIndex(for:) ---")
        
        if index != nil {
            return index!
        }
        
        return 0
    }
    
}
