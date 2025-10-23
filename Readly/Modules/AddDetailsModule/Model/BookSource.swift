//
//  BookSource.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//

import Foundation

enum BookSource {
    case json(JsonBookModelItem)
    case coreData(Book)
}
