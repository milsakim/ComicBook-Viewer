//
//  PageCell.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/21.
//

import UIKit

class PageCell: UICollectionViewCell {

    // MARK: - Outlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    
    // MARK: -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("--- PageCell awakeFromNib() ---")
    }

}
