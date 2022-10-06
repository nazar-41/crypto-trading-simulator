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
    let stat: [StatisticModel]
    @Binding var readMore: Bool
    
    var body: some View {
        VStack {
            HStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10){
                        ForEach(stat) { stat in
                            statisticItem(title: stat.title, value: stat.value)
                        }
                    }
                }
            }
            .overlay (globalStatisticsTrailingGradient, alignment: .trailing)
            .padding(.top)
            
            
            VStack(spacing: 0){
                Text("Today's Cryptocurrency Prices by Market Cap")
                    .font(.system(size: 13, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Text("The global crypto market cap is $928.98B, a 0.40% increase over the last day")
                    .font(.system(size: 12))
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
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
                
                if readMore{
                    
                    VStack(spacing: 10){
                        Group{
                            
                            Text("The total crypto market volume over the last 24 hours is **$47.05B** which makes a ") +
                            
                            
                            Text(Image(systemName: "arrowtriangle.up.fill"))
                                .foregroundColor(.green)
                                .fontWeight(.semibold) +
                            
                            Text("22.42B")
                                .foregroundColor(.green)
                                .fontWeight(.semibold) +
                            
                            Text(" increase. The total volume in DeFi is currently **$3.79B, 8.05%** of the total crypto market 24-hour volume. The volume of all stable coins is now **$44.60B**, which is **94.80%** of the total crypto market 24-hour volume. \n\nBitcoin’s dominance is currently **39.66%**, an increase of ") +
                            
                            
                            Text("0.07%")
                                .foregroundColor(.green)
                                .fontWeight(.semibold) +
                            
                            Text(" over the day")
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black.opacity(0.8))
                        
                    }
                    .font(.system(size: 13))
                    .opacity(readMore ? 1 : 0)
                    // .frame(maxHeight: readMore ? .infinity : 0)
                    .clipped()
                }
                    
            }
            .padding(.top)
        }
        .padding(10)
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.stat, readMore: .constant(false))
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
    
}
