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
    
    var body: some View {
            VStack(alignment: .trailing){
                
                HStack{
                    scoreColumnView(score: testData.score)
                    
                    volume24HColumn(volume: testData.volume24hUSD, percentage: testData.volume24Percentage)
                    
                    weeklyVisitsColumn(value: testData.weeklyVisits)
                    
                    
                    // Spacer()
                }
                .font(.system(size: 13, weight: .semibold))
        }
    }
}

struct ExchangeRowStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRowStatisticsView(testData: dev.exchange)
    }
}

extension ExchangeRowStatisticsView{
    
    //MARK: score
    @ViewBuilder private func scoreColumnView(score: Double)-> some View{
        VStack{
            ZStack{
                if score > 6.0 && score < 10 {
                    Color(.green)
                        .opacity(0.7)
                        .frame(width: 40, height: 30)
                        .cornerRadius(5)
                }else if score <= 6.0 && score > 4{
                    Color(.orange)
                        .opacity(0.7)
                        .frame(width: 40, height: 30)
                        .cornerRadius(5)
                }else if score <= 4.0{
                    Color(.red)
                        .opacity(0.7)
                        .frame(width: 40, height: 30)
                        .cornerRadius(5)
                }
                
                Text(String(format: "%.1f", score))
                    .font(.headline)
                    .foregroundColor(.white)

            }
        }
        .frame(width: 100)
    }
    
    //MARK: 24H volume
    @ViewBuilder private func volume24HColumn(volume: Double, percentage: Double)-> some View{
        VStack(alignment: .trailing, spacing: 2){
            let isIncreased = percentage > 0
            
            Text(volume.asCurrencyWith2Decimals())
            
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
