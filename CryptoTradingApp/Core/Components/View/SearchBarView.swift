//
//  SearchBarView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 02/10/2022.
//

import SwiftUI



struct SearchBarView: View {
    
    @Binding var searchBarText: String
    var body: some View {
        HStack(spacing: 0){
            Image(systemName: "magnifyingglass")
            
            TextField("Bitcoin", text: $searchBarText)
                .padding()
                .padding(.trailing, 10)
                .overlay(
                    Image(systemName: "xmark")
                        .padding(5)
                        .opacity(searchBarText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchBarText = ""
                        }
                    
                    , alignment: .trailing
                )
                .disableAutocorrection(true)
            
        }
        .font(.headline)
        .padding(.horizontal, 5)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .gray.opacity(0.2), radius: 7, x: 5, y: 5)
        )
        .padding(.horizontal)
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchBarText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
