//
//  StorageManager.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import Foundation
import UIKit

final class StorageManager {
    
    private let fileManager = FileManager.default
    private let documentsDirectory: URL
    private let coverName = "cover.jpeg"
    
    init() {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to access documents directory")
        }
        documentsDirectory = url
    }

    func saveCover(_ imageData: Data, bookId: String) {
        let fileURL = documentsDirectory.appendingPathComponent(bookId).appendingPathComponent(coverName)
        
        do {
            try imageData.write(to: fileURL, options: .atomic)
        } catch {
            print("Error saving cover image: \(error.localizedDescription)")
        }
    }
    
    func getCover(bookId: String) -> Data? {
        let fileURL = documentsDirectory.appendingPathComponent(bookId).appendingPathComponent(coverName)
        
        do {
            let imageData = try Data(contentsOf: fileURL)
            return imageData
        } catch {

            return nil
        }
    }
    

    func deleteCover(bookId: String) {
        let fileURL = documentsDirectory.appendingPathComponent(bookId)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                print("Error deleting cover image: \(error.localizedDescription)")
            }
        }
    }
}
