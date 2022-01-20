//
//  SplitViewControllerDelegate.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/30.
//

import UIKit

class MySplitViewControllerDelegate: UISplitViewControllerDelegate {
    
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        print(#function)
        
        let comicBookNavigation: UINavigationController = svc.viewControllers[2] as! UINavigationController
        let comicBookController: ComicBookController = comicBookNavigation.viewControllers[0] as! ComicBookController
        
        if comicBookController.comicBook != nil {
            return UISplitViewController.Column.secondary
        }
        
        let bookListNavigation: UINavigationController = svc.viewControllers[1] as! UINavigationController
        let bookListController: ComicBookListController = bookListNavigation.viewControllers[0] as! ComicBookListController
        
        if bookListController.category != nil {
            return UISplitViewController.Column.supplementary
        }
        
        let categoryNavigation: UINavigationController = svc.viewControllers[0] as! UINavigationController
        let categoryController: CategoryController = categoryNavigation.viewControllers[0] as! CategoryController
        
        return UISplitViewController.Column.primary
    }
    
    func splitViewController(_ svc: UISplitViewController, displayModeForExpandingToProposedDisplayMode proposedDisplayMode: UISplitViewController.DisplayMode) -> UISplitViewController.DisplayMode {
        print(#function)
        
        let comicBookNavigation: UINavigationController = svc.viewControllers[2] as! UINavigationController
        let comicBookController: ComicBookController = comicBookNavigation.viewControllers[0] as! ComicBookController
        
        if comicBookController.comicBook != nil {
            return UISplitViewController.DisplayMode.secondaryOnly
        }
        
        let bookListNavigation: UINavigationController = svc.viewControllers[1] as! UINavigationController
        let bookListController: ComicBookListController = bookListNavigation.viewControllers[0] as! ComicBookListController
        
        if bookListController.category != nil {
            return UISplitViewController.DisplayMode.twoDisplaceSecondary
        }
        
        let categoryNavigation: UINavigationController = svc.viewControllers[0] as! UINavigationController
        let categoryController: CategoryController = categoryNavigation.viewControllers[0] as! CategoryController
        
        return UISplitViewController.DisplayMode.twoDisplaceSecondary
    }
    
    func splitViewController(_ svc: UISplitViewController, willHide column: UISplitViewController.Column) {
        print(#function)
    }
    
     func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
        print(#function)
        
        let comicBookNavigation: UINavigationController = splitViewController.viewControllers[2] as! UINavigationController
        let comicBookController: ComicBookController = comicBookNavigation.viewControllers[0] as! ComicBookController
        
        if comicBookController.comicBook != nil {
            return comicBookController
        }
        
        let bookListNavigation: UINavigationController = splitViewController.viewControllers[1] as! UINavigationController
        let bookListController: ComicBookListController = bookListNavigation.viewControllers[0] as! ComicBookListController
        
        if bookListController.category != nil {
            return bookListController
        }
        
        let categoryNavigation: UINavigationController = splitViewController.viewControllers[0] as! UINavigationController
        let categoryController: CategoryController = categoryNavigation.viewControllers[0] as! CategoryController
        
        return categoryController
    }
    
}
