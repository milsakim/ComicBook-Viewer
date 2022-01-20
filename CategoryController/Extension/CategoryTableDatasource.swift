//
//  CategoryTableDatasource.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit

extension CategoryController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categories == nil {
            return 0
        }
        
        return categories!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseIdentifier) as! CategoryCell
        
        if categories != nil {
            cell.setTitle(text: categories![indexPath.row].title!)
            cell.setComicBookCount(text: String(categories![indexPath.row].comicBooks!.count))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteCategory(index: indexPath.row)
        case .insert:
            print("--- insert ---")
        default:
            print("--- CategoryController tableView(_:commit:forRowAt) default ---")
        }
    }
    
}
