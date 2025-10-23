//
//  AddDetailsObservableModel.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//

import SwiftUI

class AddDetailsObservableModel: ObservableObject {
    @Published var bookDescription: String = ""
    @Published var isLoading: Bool = false
}
