//
//  Book+CoreDataClass.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//
//

import Foundation
import CoreData

@objc(Book)
public class Book: NSManagedObject {

}

extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var bookDescription: String
    @NSManaged public var author: String
    @NSManaged public var date: Date
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var status: Int16
    @NSManaged public var notes: NSSet?
    @NSManaged public var coverURL: String?

}

// MARK: Generated accessors for notes
extension Book {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension Book : Identifiable {
    func deleteBook(){
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
