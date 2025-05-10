//
//  JsonBookModel.swift
//  Readly
//
//  Created by Илья Востров on 20.04.2025.
//

import Foundation

struct JsonBookModel: Decodable, Hashable{
    let docs: [JsonBookModelItem]
}

struct JsonBookModelItem: Decodable, Hashable{
    let author_name: [String]?
    let cover_i: Int?
    let title: String?
}

