//
//  CategoryTableViewDataSource.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/01/31.
//

import UIKit

extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categories == nil {
            return 0
        }
        
        return categories!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as! CategoryTableViewCell
    
        // Configure Cell
        if categories != nil {
            cell.titleLabel.text = categories![indexPath.row].title
            cell.comicBooksCountLabel.text = String(categories![indexPath.row].comicBooks!.count)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteCategory(index: indexPath.row)
        case .insert:
            print("insert")
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if categories != nil {
            let categoryToMove: Category = categories![sourceIndexPath.row]
            categories!.remove(at: sourceIndexPath.row)
            categories!.insert(categoryToMove, at: destinationIndexPath.row)
        }
    }
    
}
