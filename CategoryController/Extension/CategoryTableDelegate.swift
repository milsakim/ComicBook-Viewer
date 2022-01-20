//
//  CategoryTableDelegate.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit

extension CategoryController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categories != nil, indexPath.row < categories!.count {
            if splitViewController != nil {
                
                let bookListNavigation: UINavigationController = splitViewController!.viewControllers[1] as! UINavigationController
                let bookListController: ComicBookListController = bookListNavigation.viewControllers[0] as! ComicBookListController
                
                bookListController.category = categories![indexPath.row]
                
                let comicBookNavigation: UINavigationController = splitViewController!.viewControllers[2] as! UINavigationController
                let comicBookController: ComicBookController = comicBookNavigation.viewControllers[0] as! ComicBookController
                
                comicBookController.comicBook = nil
                
                splitViewController!.show(.supplementary)
            }
        }
    }
    
}
