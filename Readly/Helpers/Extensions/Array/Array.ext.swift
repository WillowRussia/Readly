//
//  Array.ext.swift
//  Readly
//
//  Created by Илья Востров on 08.05.2025.
//

import Foundation

extension Array where Element == String {
    func authorsInOneLine() -> String {
        switch self.count {
        case 0:
            return "Неизвестно"
        case 1:
            return self[0]
        default:
            return self.joined(separator: ", ")
        }
    }
}
