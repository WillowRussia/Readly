//
//  OnboardingViewContent.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import SwiftUI

struct OnboardingViewContent: View {
    
    var slides: [OnboardingSlide]
    var buttonAction: () -> Void
    
    @State private var selected: Int = 0
    var title: String {
        slides[selected].title
    }
    var buttonText: String {
            selected == slides.count - 1 ? "Начать пользоваться" : "Далее"
        }
    
    var body: some View {
        VStack {
            Text(title)
                .font(type: .black, size: 24)
                .frame(height: 70)
                .foregroundStyle(.white)
            Spacer()
            VStack {
                TabView(selection: $selected) {
                    ForEach(0..<slides.count, id: \.self) { slide in
                        SlideItem(item: slides[slide], tag: slide)
                    }
                }
                .frame(height: 437)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            Spacer()
            HStack{
                ForEach(0..<slides.count, id: \.self) { slide in
                    Circle()
                        .frame(width: 9, height: 9)
                        .foregroundStyle(slide == selected ? .orange : .white)
                        .onTapGesture {
                            withAnimation{
                                selected = slide
                            }
                            
                        }
                }
            }
            Spacer()
            VStack {
                OrangeButton(title: buttonText) {
                    if selected < slides.count - 1 {
                        withAnimation {
                            selected += 1
                        }
                        
                    } else {
                        buttonAction()
                    }
                }
                .padding(.horizontal, 30)
            }
                        
        }
        .padding(.vertical, 30)
        .background(.mainBackground)
    }
}

