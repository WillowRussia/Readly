//
//  RegistViewContent.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import SwiftUI

struct RegistViewContent: View {
    
    @State private var nameField = ""
    var buttonAction: (String) -> Void
    
    var body: some View {
        ZStack{
            VStack(){
                Text("Добро пожаловать")
                    .font(type: .black, size: 24)
                    .foregroundStyle(.white)
                Spacer()
                BaseTextView(placeholder: "Ваше имя", text: $nameField)
                Spacer()
                OrangeButton(title: "Далее") {
                    buttonAction(nameField)
                }
            }
        }
        .padding(.all, 30)
        .background(.mainBackground)
    }
}
