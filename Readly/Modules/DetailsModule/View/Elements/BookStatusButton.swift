//
//  BookStatusButton.swift
//  Readly
//
//  Created by Илья Востров on 07.04.2025.
//
import SwiftUI

struct BookStatusButton: View {
    @State private var currentStatus: BookStatus
    @State private var showStatusSelector = false
    var action: (BookStatus) -> ()
    
    init(status: BookStatus, action: @escaping (BookStatus) -> Void) {
        _currentStatus = State(initialValue: status)
        self.action = action
    }
    
    var body: some View {
        Button {
            showStatusSelector = true
        } label: {
            Text(buttonText(for: currentStatus))
                .padding(.vertical, 3)
                .padding(.horizontal, 18)
                .font(type: .bold, size: 14)
                .foregroundStyle(.white)
                .background(buttonColor(for: currentStatus))
                .clipShape(Capsule())
                .animation(.easeInOut(duration: 0.25), value: currentStatus)
        }
        .confirmationDialog("Выберите статус книги", isPresented: $showStatusSelector, titleVisibility: .visible) {
            Button("Читаю", role: .none) {
                updateStatus(.read)
            }
            Button("В планах", role: .none) {
                updateStatus(.willRead)
            }
            Button("Прочитал", role: .none) {
                updateStatus(.didRead)
            }
            Button("Отмена", role: .cancel) {
                    
                }
        }
    }
    
    private func updateStatus(_ status: BookStatus) {
        withAnimation {
            currentStatus = status
            action(status)
        }
    }
    
    private func buttonText(for status: BookStatus) -> String {
        switch status {
        case .read: return "Читаю"
        case .willRead: return "В планах"
        case .didRead: return "Прочитал"
        }
    }
    
    private func buttonColor(for status: BookStatus) -> Color {
        switch status {
        case .read: return .appRed
        case .willRead: return .appBlue
        case .didRead: return .appGreen
        }
    }
}
