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
                TextField("Ваше имя", text: $nameField)
                    .placeholder(when: nameField.isEmpty) {
                        Text("Ваше имя")
                            .foregroundColor(.appGray)
                            .padding(.leading, 2)
                    }
                    .frame (maxWidth: .infinity)
                    .frame(height: 52)
                    .padding(.horizontal, 10)
                    .background(.appDark)
                    .foregroundStyle(.white)
                    .clipShape(.rect (cornerRadius: 10))
                Spacer()
                Button {
                    buttonAction(nameField)
                } label: {
                    Text ( "Далее")
                        .padding (.vertical, 19)
                        .frame (maxWidth: .infinity)
                        .background (.appOrange)
                        .foregroundStyle(.white)
                        .clipShape(.rect (cornerRadius: 10))
                        .font(type: .bold, size: 14)
                }
            }
        }
        .padding(.all, 30)
        .background(.mainBackground)
    }
}
             
#Preview {
    RegistViewContent(buttonAction: {
        print($0)
    })
}
