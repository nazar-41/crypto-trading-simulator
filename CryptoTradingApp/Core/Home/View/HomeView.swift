//
//  HomeVIew.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 24/09/2022.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ScrollView{
            
            VStack{
                
                headerCardView
                
                    HStack(spacing: 2){
                        
                        Text("Crypto")
                            .padding(.leading)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .background(.yellow)
                        
                        Text("Holdings")
                            .padding(.leading)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .background(.yellow)
                        
                        Text("Total Profit / Avg Cost")
                            .frame(maxWidth: UIScreen.main.bounds.width / 3, maxHeight: .infinity)
                            .background(.yellow)
 
    
                        
                    }
                    .frame(height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .font(.headline)
                
                coinListView(model: [DeveloperPreview.instance.coin, DeveloperPreview.instance.coin, DeveloperPreview.instance.coin, DeveloperPreview.instance.coin,])
                    .border(.red)
                    .frame(height: UIScreen.main.bounds.height * 0.7)
                    
            }
            //.listStyle(.plain)
            
        }
        
        
    }
}

extension HomeView{
    
    //MARK: Card view
    @ViewBuilder private var headerCardView: some View{
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(10)
            
            VStack(alignment: .leading){
                HStack(spacing: 0){
                    Text("Total")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.trailing, 10)
                    
                    Image(systemName: "arrowtriangle.up.fill")
                    
                    Text("12.43%")
                }
                .font(.headline)
                .foregroundColor(.green)
                
                VStack{
                    Text("$53435.42")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold))
                }
                
                VStack{
                    Button {
                        // more code here
                    } label: {
                        Text("start trading".uppercased())
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                            .background(.yellow)
                            .cornerRadius(10)
                            .foregroundColor(.red.opacity(0.6))
                            .font(.headline)
                        
                    }
                    
                    
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
        }
        .frame(height: 150)
        .padding()
    }
    
    //MARK: Coin row
    @ViewBuilder private func coinRowView(coin: CoinModel, showHoldinsColumn: Bool)-> some View{
        VStack{
            CoinRowView(coin: coin, showHoldingsColumn: showHoldinsColumn)
            Divider()
        }
        .padding(.horizontal, 10)
        .padding(.trailing, 5)
        .padding(.vertical, 4)
    }
    
    @ViewBuilder private func coinListView(model: [CoinModel])-> some View{
        ScrollView{
            VStack{
                ForEach(model){coin in
                    //CoinRowView(coin: coin, showHoldingsColumn: false)
                    coinRowView(coin: coin, showHoldinsColumn: true)
                }
            }
        }
    }
    
}


struct HomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

