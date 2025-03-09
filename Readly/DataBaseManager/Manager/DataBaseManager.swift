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
}
