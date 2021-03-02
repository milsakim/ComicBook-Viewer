//
//  CategoryCell.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit

class CategoryCell: UITableViewCell {

    // MARK: - Outlet
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var comicBookCountLabel: UILabel!
    
    // MARK: - Property
    
    static let reuseIdentifier: String = "CategoryCell"
    
    // MARK: - Initialize
    /*
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        guard let loadedNib = Bundle.main.loadNibNamed("CategoryCell", owner: self, options: nil), let view = loadedNib.first as? UIView else {
            return
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("--- CategoryCell awakeFromNib() ---")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK:
    
    func setTitle(text: String) {
        print("--- CategoryCell setTitle ---")
        
        title.text = text
    }
    
    func setComicBookCount(text: String) {
        print("--- CategoryCell setComicBookCount ---")
        
        comicBookCountLabel.text = text
    }
    
}
