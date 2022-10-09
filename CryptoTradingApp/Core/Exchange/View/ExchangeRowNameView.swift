//
//  ExchangeRowView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 04/10/2022.
//

import SwiftUI

struct ExchangeRowNameView: View {
    
    let exchange: ExchangeModel
    
    var body: some View {
        HStack{
            ExchangeImageView(exchange: exchange)
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 5){
                Text(exchange.name ?? "")
                    .font(.system(size: 15, weight: .medium))
                
                ZStack{
                    
                    Color.gray.opacity(0.3).cornerRadius(5)
                        .frame(width: 30, height: 20)
                    
                    Text(String(exchange.trustScoreRank ?? 0))
                        .font(.system(size: 12, weight: .medium))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ExchangeRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRowNameView(exchange: dev.exchange)
    }
}
