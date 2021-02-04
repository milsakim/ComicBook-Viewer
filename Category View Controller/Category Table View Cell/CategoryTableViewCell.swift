//
//  CategoryTableViewCell.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/01/31.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - Outlet
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var comicBooksCountLabel: UILabel!
    
    // MARK: - Property
    
    static let identifier: String = "CategoryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("--- CategoryTableViewCell awakeFromNib() ---")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        print("--- CategoryTableViewCell setSelected(_:animated:) ---")
    }
    
}
