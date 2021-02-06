//
//  ComicBookTableViewCell.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/05.
//

import UIKit

class ComicBookTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    // MARK: - Property
    
    static let identifier: String = "ComicBookTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
