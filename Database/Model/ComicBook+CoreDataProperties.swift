//
//  ComicBook+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/16.
//
//

import Foundation
import CoreData


extension ComicBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ComicBook> {
        return NSFetchRequest<ComicBook>(entityName: "ComicBook")
    }

    @NSManaged public var author: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var lastAccessedDate: Date?
    @NSManaged public var modificationDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var category: Category?
    @NSManaged public var pages: NSSet?

}

// MARK: Generated accessors for pages
extension ComicBook {

    @objc(addPagesObject:)
    @NSManaged public func addToPages(_ value: Page)

    @objc(removePagesObject:)
    @NSManaged public func removeFromPages(_ value: Page)

    @objc(addPages:)
    @NSManaged public func addToPages(_ values: NSSet)

    @objc(removePages:)
    @NSManaged public func removeFromPages(_ values: NSSet)

}

extension ComicBook : Identifiable {

}
