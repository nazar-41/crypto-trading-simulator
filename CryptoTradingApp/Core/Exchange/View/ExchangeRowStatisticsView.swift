//
//  ExchangeRowStatisticsView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 04/10/2022.
//

import SwiftUI

struct ExchangeRowStatisticsView: View {
    let columnWidth: CGFloat = 130
    
    let testData: ExchangeModel
    let btcModel: CoinModel?
    
    var body: some View {
            VStack(alignment: .trailing){
                
                HStack{
                    scoreColumnView(score: testData.trustScore ?? 0)
                    
                    //volume24HColumn(volume: testData.tradeVolume24hBTCNormalized ?? 0, percentage: 0)
                    
                   // volume24HColumn(volume: testData.tradeVolume24hUSD(btcPrice: btcPrice))
                    volume24HColumn(volume: testData.tradeVolume24hUSD(btcModel: btcModel))

                    
                    countryColumn(country: testData.country)
                    
                    yearEstablishedColumn(year: testData.yearEstablished)
                    
                    websiteColumn(name: testData.name, url: testData.url)
                    
                    // Spacer()
                }
                .font(.system(size: 13, weight: .semibold))
                .padding(.trailing)
        }
    }
}

struct ExchangeRowStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRowStatisticsView(testData: dev.exchange, btcModel: dev.coin)
    }
}

extension ExchangeRowStatisticsView{
    
    //MARK: score
    @ViewBuilder private func scoreColumnView(score: Int)-> some View{
        VStack{
            ZStack{
                if score > 6 && score <= 10 {
                    Color(.green)
                        .opacity(0.7)
                        .frame(width: 40, height: 30)
                        .cornerRadius(5)
                }else if score <= 6 && score > 4{
                    Color(.orange)
                        .opacity(0.7)
                        .frame(width: 40, height: 30)
                        .cornerRadius(5)
                }else if score <= 4{
                    Color(.red)
                        .opacity(0.7)
                        .frame(width: 40, height: 30)
                        .cornerRadius(5)
                }
                
                Text("\(score)")
                    .font(.headline)
                    .foregroundColor(.white)

            }
        }
        .frame(width: 100)
    }
    
    //MARK: 24H volume
    @ViewBuilder private func volume24HColumn(volume: Int)-> some View{
        VStack(alignment: .trailing, spacing: 2){
            Text("$\(volume)")
        }
        .frame(width: columnWidth, alignment: .trailing)

    }
    
    //MARK: 7d visits
    @ViewBuilder private func countryColumn(country: String?)-> some View{
        VStack{
            Text(country ?? "N/A")
        }
        .frame(width: columnWidth, alignment: .trailing)
    }
    
    @ViewBuilder private func yearEstablishedColumn(year: Int?)-> some View{
        VStack{
            if let wrapped = year{
                Text(String(wrapped))
            }else{
                Text("N/A")
            }
        }
        .frame(width: columnWidth, alignment: .trailing)
    }
    
    @ViewBuilder private func websiteColumn(name: String?, url: String?)-> some View{
        VStack{
            if let wrappedURL = URL(string: url ?? ""),
               let wrappedName = name{
                //Text("[\(wrappedName)](\(wrappedURL)")
                Link(wrappedName, destination: wrappedURL)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.trailing)
            }else{
                Text("N/A")
            }
        }
        .frame(width: columnWidth, alignment: .trailing)
    }
}
