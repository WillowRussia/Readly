//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI
struct DetailsViewContent: View {
    @State var bookNote: String = ""
    var body: some View {
        ZStack(alignment: .top){
            HStack(spacing: 20){
                Button {
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 24)
                }
                Spacer()
                
                Text("О книге")
                    .font(size: 18)
                    .foregroundStyle(.white)
                
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFill()
                        .rotationEffect(.degrees(90))
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 6)
                }
            }
            .padding(.top, 15)
            .padding(.horizontal, 30)
            .zIndex(1)
            
            ScrollView{
                VStack(spacing: 29){
                    ZStack(alignment: .top){
                        GeometryReader { proxy in
                            let minY = proxy.frame(in: .global).minY
                            
                            Image(.testCover)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: proxy.size.width)
                                .frame(height: 400 + minY)
                                .clipped()
                                .overlay {
                                    Color(.appOrange).opacity(0.4)
                                }
                                .offset(y: -minY)
                        }
                        .frame(height: 400)
                        
                        VStack(spacing: 15) {
                            Image(.testCover)
                                .resizable()
                                .frame(width: 143, height: 212)
                                .clipShape(.rect(cornerRadius: 5))
                            VStack(spacing: 2){
                                Text ("Моя жизнь")
                                    .font(type: .bold, size: 20)
                                Text ("Илья Востров")
                                    .font(type: .medium, size: 16)
                            }
                            .foregroundStyle(.white)
                            BookStatusButton(status: .read) {
                                //
                            }
                        }
                        .padding(.top, 55)
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 36){
                        VStack(alignment: .leading, spacing: 12){
                            Text ("Описание")
                                .font(type: .black, size: 18)
                                .foregroundStyle(.white)
                            Text ("Очень важно описние, которое люди никогда не читают. Очень важно описние, которое люди никогда не читают. Очень важно описние, которое люди никогда не читают.")
                                .font (size: 14)
                                .foregroundStyle(.appGray)
                        }
                        
                        VStack(alignment: .leading, spacing: 14) {
                            Text ("Заметки по книге")
                                .font(type: .bold, size: 18)
                                .foregroundStyle(.white)
                            VStack(alignment: .leading, spacing: 14){
                                CommentView()
                                CommentView()
                                
                            }
                            BaseTextView(placeholder: "Добавить заметку", text: $bookNote)
                              
                        }
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.bottom, 30)
            }
            
        }
        .background(.mainBackground)
    }
}

#Preview {
    DetailsViewContent()
}
