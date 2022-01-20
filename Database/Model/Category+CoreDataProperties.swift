//
//  Category+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/01/29.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var lastAccessedDate: Date?
    @NSManaged public var modificationDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var comicBooks: NSSet?

}

// MARK: Generated accessors for comicBooks
extension Category {

    @objc(addComicBooksObject:)
    @NSManaged public func addToComicBooks(_ value: ComicBook)

    @objc(removeComicBooksObject:)
    @NSManaged public func removeFromComicBooks(_ value: ComicBook)

    @objc(addComicBooks:)
    @NSManaged public func addToComicBooks(_ values: NSSet)

    @objc(removeComicBooks:)
    @NSManaged public func removeFromComicBooks(_ values: NSSet)

}

extension Category : Identifiable {

}
