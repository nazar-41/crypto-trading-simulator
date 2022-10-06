//
//  ExchangeRowStatisticsView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 04/10/2022.
//

import SwiftUI

struct ExchangeRowStatisticsView: View {
    let columnWidth: CGFloat = 130 //UIScreen.main.bounds.width / 3
    
    var body: some View {
        ScrollView(.horizontal){
            VStack(alignment: .trailing){
                HStack{
                    Text("Score")
                        .frame(width: columnWidth)
                    
                    Text("Valume 24h")
                        .frame(width: columnWidth, alignment: .trailing)
                    
                    Text("Weekly visits")
                        .frame(width: columnWidth, alignment: .trailing)
                    
                    
                }
                .font(.caption)
                
                HStack{
                    scoreColumnView(score: 4)
                    
                    volume24HColumn(volume: 32424223.56, percentage: -23)
                    
                    weeklyVisitsColumn(value: 1354543582)
                    
                    
                    // Spacer()
                }
                .font(.system(size: 13, weight: .semibold))
            }
        }
    }
}

struct ExchangeRowStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRowStatisticsView()
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
        .frame(width: columnWidth)
        .border(.red)
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
        .border(.yellow)
    }
    
    //MARK: 7d visits
    @ViewBuilder private func weeklyVisitsColumn(value: Int)-> some View{
        VStack{
            Text("\(value)")
        }
        .frame(width: columnWidth, alignment: .trailing)
        .border(.green)
    }
    

}
