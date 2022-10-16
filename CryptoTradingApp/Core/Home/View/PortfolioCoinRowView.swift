//
//  PortfolioCoinRowView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 16/10/2022.
//

import SwiftUI

struct PortfolioCoinRowView: View {
    let coin: CoinModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("\(coin.rank).")
                    .font(.subheadline)

                
                CoinImageView(coin: coin)
                    .frame(width: 40, height: 40)
                
                Text(coin.name)
                    .font(.headline)

                
                Spacer()
            }
            
            
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    HStack(spacing: 0){
                        Text("Bought price")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(width: 80, alignment: .leading)
                        
                        Text(": " + (coin.boughtPrice ?? 0.0).asCurrencyWith2Decimals())
                            .font(.system(size: 11, weight: .semibold))
                         //   .lineLimit(1)
                        //    .minimumScaleFactor(0.8)
                        
                        
                    }
                    .padding(.top)
                    
                    HStack(spacing: 0){
                        Text("Amount")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(width: 80, alignment: .leading)
                        
                        
                        Text(": " + (coin.currentHoldings ?? 0.0).asDoubleWith3Decimals())
                            .font(.system(size: 11, weight: .semibold))
                          //  .lineLimit(1)
                          //  .minimumScaleFactor(0.8)
                        
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10){
                    HStack(spacing: 0){
                        Text("Current price")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(width: 80, alignment: .leading)
                        
                        Text(": " + coin.currentPrice.asCurrencyWith2Decimals())
                            .font(.system(size: 11, weight: .semibold))
                           // .lineLimit(1)
                          //  .minimumScaleFactor(0.8)
                        
                        
                    }
                    .padding(.top)
                    
                    HStack(spacing: 0){
                        Text("Profit")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(width: 80, alignment: .leading)
                        
                        
                        Text(": " + coin.profit.asCurrencyWith2Decimals())
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(coin.profit > 0 ? .green : .red)
                          //  .lineLimit(1)
                          //  .minimumScaleFactor(0.8)
                        
                    }
                }

            }
        }
        .padding(.horizontal, 10)
    }
    
    private func profitUSD(coin: CoinModel)-> String{
        let difference = coin.currentPrice - (coin.boughtPrice ?? 0)
        
        guard let holdings = coin.currentHoldings else{return "$0"}
        
        return (difference * holdings).asCurrencyWith6Decimals()
    }
    
  //  private func profitPercentage(coin: CoinModel)-> Double
}

struct PortfolioCoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioCoinRowView(coin: dev.coin)
    }
}
