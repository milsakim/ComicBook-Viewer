//
//  CollectionViewDatasource.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/21.
//

import UIKit

extension ComicBookController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pages == nil {
            return 0
        }
        
        return pages!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as! PageCell
        
        if pages != nil {
            if indexPath.row < pages!.count {
                /*
                let fileManager: FileManager = FileManager.default
                let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
                
                if urls.count > 0 {
                    let documentsDirectory: URL = urls[0]
                    let defaultDirectory: URL = documentsDirectory.appendingPathComponent(DirectoryPath.defaultDirectory.rawValue)
                    let comicBookDirectory: URL = defaultDirectory.appendingPathComponent(comicBook!.id!.uuidString)
                    let imageURL: URL = comicBookDirectory.appendingPathComponent("\(pages![indexPath.row].id!)-thumbnail.jpg")
                    
                    print("$$$ \(imageURL.path) $$$")
                    cell.imageView.image = UIImage(contentsOfFile: imageURL.path)
                    cell.indexLabel.text = "\(pages![indexPath.row].index)"
                }
                */
                
                if comicBookDirectory != nil {
                    let imageURL: URL = comicBookDirectory!.appendingPathComponent("\(pages![indexPath.row].id!)-thumbnail.jpg")
                    print("$$$ \(imageURL.path) $$$")
                    cell.imageView.image = UIImage(contentsOfFile: imageURL.path)
                    cell.indexLabel.text = "\(pages![indexPath.row].index)"
                }
                
                print("$$$ \(pages![indexPath.row].index) ---")
            }
        }
        
        return cell
    }
    
}
