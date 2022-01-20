//
//  BookTableDatasource.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/15.
//

import UIKit

extension ComicBookListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if comicBooks == nil {
            return 0
        }
        
        return comicBooks!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BookCell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseIdentifier) as! BookCell
        
        if comicBooks != nil {
            cell.titleLabel.text = comicBooks![indexPath.row].title
            cell.authorLabel.text = comicBooks![indexPath.row].author
            
            if comicBooks![indexPath.row].thumbnail != nil {
                let fileManager: FileManager = FileManager.default
                let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
                
                if urls.count > 0 {
                    let documentsDirectory: URL = urls[0]
                    let defaultDirectory: URL = documentsDirectory.appendingPathComponent(DirectoryPath.defaultDirectory.rawValue)
                    let comicBookDirectory: URL = defaultDirectory
                        .appendingPathComponent(comicBooks![indexPath.row].id!.uuidString)
                    let thumbnail: URL = comicBookDirectory.appendingPathComponent("\(comicBooks![indexPath.row].id!.uuidString).jpg")
                    
                    print("%%% tableview: \(thumbnail.path) %%%")
                    
                    if fileManager.fileExists(atPath: thumbnail.path) {
                        cell.thumbnailImageView.image = UIImage(contentsOfFile: thumbnail.path)
                    }
                }
            } else {
                cell.thumbnailImageView.image = UIImage(named: "NoSelectedThumbnail")
            }
        }
        
        return cell
    }
    
}
