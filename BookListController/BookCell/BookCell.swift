//
//  BookCell.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit

class BookCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Property
    
    static let reuseIdentifier: String = "BookCell"
    
    // MARK: -

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("--- BookCell awakeFromNib() ---")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: -
    
    func setThumbnailImageView(url: URL) {
        
    }
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    func setAuthorLabel(text: String?) {
        if text != nil {
            authorLabel.text = text!
        } else {
            authorLabel.text = "No Author"
        }
    }
    
}
