//
//  CoreDataManager.swift
//  Readly
//
//  Created by Илья Востров on 03.10.2025.
//


import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Readly")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Operations for Book
    
    func createBook(name: String, author: String, description: String, coverURL: String) -> Book? {
        let context = persistentContainer.viewContext
        let book = Book(context: context)
        book.id = UUID().uuidString
        book.name = name
        book.author = author
        book.status = BookStatus.willRead.rawValue
        book.bookDescription = description
        book.date = Date()
        book.coverURL = coverURL
        
        saveContext()
        return book
    }
    
    func updateBook(_ book: Book, name: String, author: String, description: String, coverURL: String) {
        book.name = name
        book.author = author
        book.bookDescription = description
        book.coverURL = coverURL
        
        saveContext()
    }
    
    func deleteBook(_ book: Book) {
        let context = persistentContainer.viewContext
        if let notes = book.notes as? Set<Note> {
            for note in notes {
                context.delete(note)
            }
        }
        context.delete(book)
        saveContext()
    }
    
    func fetchBooks() -> [Book] {
        let request = Book.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Failed to fetch books: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Note Operations
    
    func addNote(to book: Book, text: String) {
        let context = persistentContainer.viewContext
        let note = Note(context: context)
        note.id = UUID().uuidString
        note.text = text
        note.date = Date()
        
        book.addToNotes(note)
        saveContext()
    }

    func deleteNote(_ note: Note) {
        let context = persistentContainer.viewContext
        context.delete(note)
        saveContext()
    }
}
