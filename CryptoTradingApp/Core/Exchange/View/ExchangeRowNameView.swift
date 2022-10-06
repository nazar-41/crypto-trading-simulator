//
//  ExchangeRowView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 04/10/2022.
//

import SwiftUI

struct ExchangeRowNameView: View {
    var body: some View {
        HStack{
            Circle()
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 0){
                Text("Binance")
                    .font(.headline)
                
                ZStack{
                    Color.gray.opacity(0.3).cornerRadius(5)
                        .frame(width: 20, height: 30)
                    
                    Text("1")
                        .font(.subheadline)
                }
            }
        }
    }
}

struct ExchangeRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRowNameView()
    }
}
