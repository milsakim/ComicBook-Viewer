//
//  CategoryTableViewDelegate.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/01/31.
//

import UIKit

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--- selected category: \(categories![indexPath.row].title) ---")
        
        if categories != nil, splitViewController != nil {
            let navigationController: UINavigationController = splitViewController!.viewControllers[1] as! UINavigationController
            let comicBookViewController: ComicBookViewController = navigationController.viewControllers[0] as! ComicBookViewController
            
            // Configure Comic Book View Controller
            comicBookViewController.category = categories![indexPath.row]
        }
    }
    
}
