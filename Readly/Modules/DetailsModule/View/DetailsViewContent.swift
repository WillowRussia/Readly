//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI
struct DetailsViewContent: View {
    @State var bookNote: String = ""
    @State var offsetTop: CGFloat = 0
    @State var showTitle: Bool = false
    @State var commetDeleteOffsetX: CGFloat = 0
    var bookName = "Моя жизнь"
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
                
                Text((showTitle ? bookName : "О книге"))
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
            .padding(.top, 10)
            .padding(.horizontal, 30)
            .padding(.bottom, 15)
            .zIndex(1)
            .background(
                .mainBackground.opacity(offsetTop < 0 ? (-offsetTop * 5.3 / 1000) : 0)
                )
            
            ScrollView(showsIndicators: false){
                VStack(spacing: 29){
                    ZStack(alignment: .top){
                        GeometryReader { proxy in
                            let minY = proxy.frame(in: .global).minY
                            
                            Image(.defaultCover)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: proxy.size.width)
                                .frame(height: 400 + (minY > 0 ? minY : 0))
                                .clipped()
                                .overlay {
                                    Color(.appOrange).opacity(0.4)
                                }
                                .offset(y: minY > 0 ? -minY : 0)
                                .onChange(of: minY) { newValue in
                                    offsetTop = newValue
                                    withAnimation {
                                        showTitle = newValue < -190 ? true : false
                                    }
                                    
                                }
                        }
                        .frame(height: 400)
                        
                        VStack(spacing: 15) {
                            Image(.defaultCover)
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
                                ZStack(alignment: .trailing){
                                    CommentView()
                                        .offset(x: -commetDeleteOffsetX)
                                        .gesture(
                                            DragGesture ()
                                                .onChanged({ value in
                                                    if value.translation.width < -commetDeleteOffsetX {
                                                        commetDeleteOffsetX = abs (value.translation.width)
                                                    }
                                                    
                                                })
                                                .onEnded ({ value in
                                                    if value.translation.width < -100 {
                                                        commetDeleteOffsetX = 150
                                                    }else {
                                                               commetDeleteOffsetX = 0
                                                           }
                                                })
                                        )
                                        .zIndex(1)
                                    
                                    Button{
                                        
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundStyle(.white)
                                            
                                            .opacity (commetDeleteOffsetX > 0 ?
                                            (commetDeleteOffsetX/100) : 0)
                                            .padding(.trailing, 40)
                                    }
                                }
                                
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
