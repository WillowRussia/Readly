//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI

struct BookListViewContent: View {
    var body: some View {
        ZStack(alignment: .top){
            
            NavigationHeader(title: "Моя жизнь") {
                //
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Результаты поиска")
                        .foregroundStyle(.white)
                        .font(size: 16)
                        .padding(.horizontal, 5)
                    
                    VStack(alignment: .leading, spacing: 23 ){
                        BookListItem(){}
                        BookListItem(){}
                        BookListItem(){}
                        BookListItem(){}
                        BookListItem(){}
                    }
                    
                }
                
            }
            .padding(.top, 44)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 30)
        .background (.mainBackground)
    }
}


#Preview {
    BookListViewContent()
}
