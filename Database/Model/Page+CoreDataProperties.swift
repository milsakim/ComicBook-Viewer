//
//  Page+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/03.
//
//

import Foundation
import CoreData


extension Page {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Page> {
        return NSFetchRequest<Page>(entityName: "Page")
    }

    @NSManaged public var id: String?
    @NSManaged public var index: Int64
    @NSManaged public var width: Float
    @NSManaged public var height: Float
    @NSManaged public var comicBook: ComicBook?

}

extension Page : Identifiable {

}
