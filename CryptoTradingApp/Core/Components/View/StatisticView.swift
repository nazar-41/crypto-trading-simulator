//
//  StatisticView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 03/10/2022.
//



//MARK: description text
/*
 
 Today's Cryptocurrency Prices by Market Cap
 The global crypto market cap is $928.98B, a 0.40% increase over the last day.Read Less
 The total crypto market volume over the last 24 hours is $47.05B, which makes a 22.93% increase. The total volume in DeFi is currently $3.79B, 8.05% of the total crypto market 24-hour volume. The volume of all stable coins is now $44.60B, which is 94.80% of the total crypto market 24-hour volume.
 Bitcoin’s dominance is currently 39.66%, an increase of 0.07% over the day.
 
 */

import SwiftUI

struct StatisticView: View {
    let marketDataModel: MarketDataModel
    @Binding var readMore: Bool
    
    
    var body: some View {
        VStack {
                
                HStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10){
                            
                            statisticItem(title: "Cryptos", value: "\(marketDataModel.activeCryptocurrencies)")
                            statisticItem(title: "Exchanges", value: "\(marketDataModel.markets)")
                            statisticItem(title: "Market Cap", value: marketDataModel.marketCap.asCurrencyWith2Decimals())
                            statisticItem(title: "24h Vol", value: marketDataModel.volume.asCurrencyWith2Decimals())
                            statisticItem(title: "Dominance", value: "BTC: " + marketDataModel.bitcoinDominance.asPercentString())
                            
                            
                        }
                        .padding(.trailing, 50)
                    }
                }
                .overlay (globalStatisticsTrailingGradient, alignment: .trailing)
                .padding(.top)
                
                
                VStack(spacing: 0){
                    
                    headerTextView(model: marketDataModel)
                    
                    if readMore{
                        
                        readMoreView(model: marketDataModel)
                        
                    }
                    
                }
                .padding(.top)
            }
       // }
        
        .padding(10)
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(marketDataModel: dev.marketData, readMore: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}


extension StatisticView{
    
    @ViewBuilder private func statisticItem(title: String, value: String)-> some View{
        HStack(spacing: 1){
            Text(title + ": ")
            Text(value)
                .foregroundColor(.blue)
        }
        .font(.system(size: 12, weight: .regular))
    }
    
    @ViewBuilder private var globalStatisticsTrailingGradient: some View{
        Rectangle()
            .fill(LinearGradient(colors: [.clear, .white], startPoint: .leading, endPoint: .trailing))
            .frame(width: 50)
        
    }
    
    @ViewBuilder private func headerTextView(model: MarketDataModel)-> some View{
        VStack{
            
            Text("Today's Cryptocurrency Prices by Market Cap")
                .font(.system(size: 13, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            Group{
                
                Text("The global crypto market cap is **$\(model.marketCap.formattedWithAbbreviations())**, a ")
                    .font(.system(size: 13)) +
                // .padding(.top, 10)
                // .frame(maxWidth: .infinity, alignment: .leading)
                // .multilineTextAlignment(.leading) +
                
                Text(model.marketCapChangePercentage24HUsd.asPercentString())
                    .foregroundColor(model.marketCapChangePercentage24HUsd > 0 ? .green : .red)
                    .fontWeight(.semibold)
                    .font(.system(size: 13)) +
                
                Text(" \(model.marketCapChangePercentage24HUsd > 0 ? "increase" : "decrease")  over the last day")
                    .font(.system(size: 13))
            }
            .padding(.top, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                Spacer()
                
                Button {
                    withAnimation(.linear(duration: 0.2)) {
                        readMore.toggle()
                    }
                } label: {
                    Text(readMore ? "Read less" : "Read more")
                        .underline()
                        .foregroundColor(.gray)
                        .font(.system(size: 13, weight: .semibold))
                }
                .padding(.bottom, 10)
                
            }
        }
        
    }
    
    @ViewBuilder private func readMoreView(model: MarketDataModel)-> some View{
        VStack(spacing: 10){
            Group{
                
                Text("The total crypto market volume over the last 24 hours is **$\(model.volume.formattedWithAbbreviations())**") +
                
                Text("\n\nBitcoin’s dominance is currently **\(model.bitcoinDominance.asPercentString())**")
    
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .foregroundColor(.black.opacity(0.8))
            
        }
        .font(.system(size: 13))
        .opacity(readMore ? 1 : 0)
        .clipped()
    }
    
}
