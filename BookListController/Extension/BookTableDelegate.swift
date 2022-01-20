//
//  BookTableDelegate.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit

extension ComicBookListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if comicBooks != nil, indexPath.row < comicBooks!.count {
            if splitViewController != nil {
                let comicBookNavigation: UINavigationController = splitViewController!.viewControllers[2] as! UINavigationController
                let comicBookController: ComicBookController = comicBookNavigation.viewControllers[0] as! ComicBookController
                
                comicBookController.comicBook = comicBooks![indexPath.row]
            
                splitViewController!.hide(.primary)
            }
        }
    }
    
}
