//
//  UnderlineTextFieldView.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import SwiftUI

struct UnderlineTextFieldView<TextFieldView>: View where TextFieldView: View {

     @Binding var text: String
     let textField: TextFieldView
     let placeholder: String

     
     var body: some View {
          HStack {
               underlineTextFieldView
          }
     }
}

extension UnderlineTextFieldView {
     
     private var underlineTextFieldView: some View {
          VStack {
               ZStack(alignment: .leading) {
                    if text.isEmpty {
                         placeholderView
                    }

               textField
                    .padding(.trailing, 16)
               }

               underlineView
          }
     }

     private var placeholderView: some View {
          Text(placeholder)
             .font(.system(size: 16))
             .foregroundColor(Color("grayTextColor"))
               .opacity(0.5)
     }

     private var underlineView: some View {
          Rectangle().frame(height: 1)
               .foregroundColor(Color("mainColor"))
               .padding(.trailing, 16)
     }
}
