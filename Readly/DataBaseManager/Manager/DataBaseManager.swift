//
//  SoreManager.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//
import Foundation
import CoreData

final class DataBaseManager {
    
    static let shared = DataBaseManager()
    private var storageManager = StorageManager()
    private init() {}
    
    var books: [Book] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer (name: "Readly")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try
                context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension DataBaseManager {
    
    func createBook(name: String, author: String, cover: Data, description: String) {
        let bookId = UUID().uuidString
        let _: Book = {
            $0.id = bookId
            $0.name = name
            $0.author = author
            $0.status = BookStatus.read.rawValue
            $0.coverURL = "cover.jpeg"
            $0.bookDescription = description
            $0.date = Date()
            return $0
        }(Book(context: persistentContainer.viewContext))
        
        saveContext()
        storageManager.saveCover(bookId: bookId, cover: cover)
    }
    
    func getBook(by id: NSManagedObjectID) -> Book? {
        return try? persistentContainer.viewContext.existingObject(with: id) as? Book
    }

    
    func updateBook(_ book: Book, name: String? = nil, author: String? = nil, description: String? = nil, status: BookStatus? = nil, cover: Data? = nil) {
        if let name = name {
            book.name = name
        }
        if let author = author {
            book.author = author
        }
        if let description = description {
            book.bookDescription = description
        }
        if let status = status {
            book.status = status.rawValue
        }
        
        if let cover = cover {
            storageManager.saveCover(bookId: book.id, cover: cover)
        }

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

        storageManager.deleteCover(bookId: book.id)

        saveContext()

        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books.remove(at: index)
        }
    }
    
    func fetchBooks (){
        let request = Book.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            let books = try persistentContainer.viewContext.fetch(request)
            self.books = books
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addNote(book: Book, noteText: String){
        
        let _ : Note = {
            $0.date = Date()
            $0.id = UUID().uuidString
            $0.book = book
            return $0
        }(Note(context: persistentContainer.viewContext))
        
    }
    
    func getNotes(for book: Book) -> [Note] {
            guard let notes = book.notes as? Set<Note> else { return [] }
        return notes.sorted { ($0.date) > ($1.date) }
        }
    
    func addNote(to book: Book, text: String) {
            let context = persistentContainer.viewContext
            let note = Note(context: context)
            note.id = UUID().uuidString
            note.text = text
            note.date = Date()
            note.book = book
            
            book.addToNotes(note)
            saveContext()
        }

        func deleteNote(_ note: Note, from book: Book) {
            let context = persistentContainer.viewContext
            book.removeFromNotes(note)
            context.delete(note)
            saveContext()
        }
}
