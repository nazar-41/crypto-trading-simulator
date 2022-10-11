//
//  ExchangeRowView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 04/10/2022.
//

import SwiftUI

struct ExchangeRowView: View {
    
    let exchange: ExchangeModel
    
    let columnWidth: CGFloat = 120
    
    let btcPrice: Double?
    
    var body: some View {
        HStack{
            ExchangeImageView(exchange: exchange)
                .frame(width: 30, height: 30)
            
            nameRankView(name: exchange.name, trustScoreRank: exchange.trustScoreRank)

            
            Spacer()
            
            scoreView(score: exchange.trustScore ?? 0)
            
            Spacer()
            
            volume24H(volume: exchange.tradeVolume24hUSD(btcPrice: btcPrice))
             
        }
        .font(.system(size: 14, weight: .medium))
    }
}

struct ExchangeRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRowView(exchange: dev.exchange, btcPrice: dev.vm_homeview.btcPrice)
    }
}


extension ExchangeRowView{
    
    @ViewBuilder private func nameRankView(name: String, trustScoreRank: Int?)-> some View{
        HStack {
            VStack(alignment: .leading, spacing: 5){
                Text(name)
                    .font(.system(size: 14, weight: .medium))
                    .frame(width: columnWidth, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                ZStack{
                    
                    Color.gray.opacity(0.3).cornerRadius(5)
                        .frame(width: 30, height: 20)
                    
                    Text(String(trustScoreRank ?? 0))
                        .font(.system(size: 12, weight: .medium))
                }
            }
        }
    }
    
    
    @ViewBuilder private func scoreView(score: Int)-> some View{
        VStack{
            ZStack{
                
                if score >= 8 && score <= 10 {
                    Color.green.cornerRadius(10)

                }else if score >= 6 && score < 8{
                    Color.orange.cornerRadius(10)

                }else if score < 6{
                    Color.red.cornerRadius(10)

                }
                
                
                Text(String(score))
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
            }
            .frame(width: 40, height: 30)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    @ViewBuilder private func volume24H(volume: Int)-> some View{
        VStack{
            Text(volume.asCurrency())
                .frame(alignment: .trailing)
                .font(.system(size: 12, weight: .semibold))
        }
        .frame(width: columnWidth, alignment: .trailing)
    }
}
