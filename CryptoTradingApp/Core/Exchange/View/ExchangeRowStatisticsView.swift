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
    let btcPrice: Double
    
    var body: some View {
            VStack(alignment: .trailing){
                
                HStack{
                    scoreColumnView(score: testData.trustScore ?? 0)
                    
                    //volume24HColumn(volume: testData.tradeVolume24hBTCNormalized ?? 0, percentage: 0)
                    
                    volume24HColumn(volume: testData.tradeVolume24hUSD(btcPrice: btcPrice), percentage: 0)

                    
                    weeklyVisitsColumn(value: 0)
                    
                    
                    // Spacer()
                }
                .font(.system(size: 13, weight: .semibold))
        }
    }
}

struct ExchangeRowStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRowStatisticsView(testData: dev.exchange, btcPrice: 13533.24)
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
    @ViewBuilder private func volume24HColumn(volume: Int, percentage: Double)-> some View{
        VStack(alignment: .trailing, spacing: 2){
            let isIncreased = percentage > 0
            
            Text("\(volume)")
            
            HStack(spacing: 0){
                Image(systemName: "arrowtriangle.up.fill")
                    .foregroundColor(isIncreased ? .green : .red)
                    .font(.caption)
                    .rotationEffect(Angle(degrees: percentage > 0 ? 0 : 180))
                
                Text("\(percentage.asPercentString())")
                    .foregroundColor(isIncreased ? .green : .red)
            }
            
        }
        .frame(width: columnWidth, alignment: .trailing)
    }
    
    //MARK: 7d visits
    @ViewBuilder private func weeklyVisitsColumn(value: Int)-> some View{
        VStack{
            Text("\(value)")
        }
        .frame(width: columnWidth, alignment: .trailing)
    }
    

}
