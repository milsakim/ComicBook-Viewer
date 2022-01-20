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

    @NSManaged public var id: UUID?
    @NSManaged public var index: Int64
    @NSManaged public var width: Double
    @NSManaged public var height: Double
    @NSManaged public var comicBook: ComicBook?

}

extension Page : Identifiable {

}
