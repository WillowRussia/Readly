//
//  Untitled.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import Foundation

class StorageManager {
    
    private var path = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)[0]
    
    func saveCover(bookId: String, cover: Data){
        var bookPath = path.appending (component: bookId)
        try? FileManager.default.createDirectory(at: bookPath, withIntermediateDirectories: true)
        var coverPath = bookPath.appending(component: "cover jpeg")
        
        do {
            try cover.write(to: coverPath)
        } catch {
            print(error.localizedDescription)
            
        }
    }
    
    func getCover(bookId: String) -> Data?{
        var coverPath = path
            .appending (component: bookId)
            .appending (component: "cover.jpeg")
         
        do {
            let coverData = try Data (contentsOf: coverPath)
            return coverData
        } catch {
            print (error.localizedDescription)
            return nil
        }
    }
}
