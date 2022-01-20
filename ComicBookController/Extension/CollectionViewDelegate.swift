//
//  CollectionViewDelegate.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/21.
//

import UIKit

extension ComicBookController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
        if viewer == nil {
            viewer = ComicBookViewer()
        }
        
        if comicBookDirectory != nil, pages != nil {
            print("$$$$$$ \(images) &&&&")
            // viewer?.images = images
            viewer?.comicBookDirectory = comicBookDirectory
            
            if viewer?.pageIDs == nil {
                viewer?.pageIDs = []
            }
         
            for page in pages! {
                
                viewer?.pageIDs?.append(page.id!.uuidString)
            }
            
            print("\(viewer?.pageIDs!)")
            
            viewer?.index = indexPath.row
        } else {
            print("$$$$$$ no images &&&&")
        }
        
        let navigation: UINavigationController = splitViewController?.viewControllers[2] as! UINavigationController
        navigation.pushViewController(viewer!, animated: true)
        splitViewController?.hide(.supplementary)
        */
        
        if viewer2 == nil {
            viewer2 = ComicBookViewerController()
        }
        
        if viewer2 != nil, pages != nil {
            if viewer2!.pageIDs == nil {
                viewer2!.pageIDs = []
            }
            
            if viewer2!.pageIDs != nil {
                for page in pages! {
                    viewer2!.pageIDs!.append(page.id!.uuidString)
                }
                
                viewer2!.comicBookDirectory = comicBookDirectory
                viewer2!.index = indexPath.row
                
                print("--- viewer2 pageIDs: \(viewer2!.pageIDs!) ---")
            }
        }
        
        let navigation: UINavigationController = splitViewController?.viewControllers[2] as! UINavigationController
        navigation.pushViewController(viewer2!, animated: true)
        
        splitViewController?.hide(.supplementary)
    }
    
}
