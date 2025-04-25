//
//  CommentView.swift
//  Readly
//
//  Created by Илья Востров on 07.04.2025.
//
import SwiftUI

struct CommentView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("13.01.25")
                .foregroundStyle(.white)
                .font (size: 12)
            Text ("Очень важно описние, которое люди никогда не читают. Очень важно описние, которое люди никогда не читают. Очень важно описние, которое люди никогда не читают. Очень важно описние, которое люди никогда не читают")
        }
                .foregroundStyle(.appGray)
                .font(size: 13)
                .padding (.vertical, 12)
                .padding(.horizontal, 21)
                .background(.appDark)
                .clipShape(.rect(cornerRadius: 10))
            
    }
}
