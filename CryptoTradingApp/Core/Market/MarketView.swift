//
//  MarketView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 27/09/2022.
//

import SwiftUI

struct MarketView: View {
    @EnvironmentObject private var vm_homeview: VM_HomeView
    
    @State private var readMore: Bool = false
    
    var body: some View {
        VStack{
            
            SearchBarView(searchBarText: $vm_homeview.searchBarText, placeholderText: "Bitcoin")
            
           // StatisticView(stat: DeveloperPreview.instance.stat, readMore: $readMore)
            if let globalMarketData = vm_homeview.globalMarketData{
                StatisticView(marketDataModel: globalMarketData, readMore: $readMore)
            }
            
            listTitleView
            
            coinListView
            
        }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
            .environmentObject(dev.vm_homeview)
    }
}


extension MarketView{
    
    //MARK: List header view
    @ViewBuilder private var listTitleView:  some View{
        HStack(spacing: 2){
            
            Text("Crypto")
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack {
                Text("Price")
                
                Button {
                    vm_homeview.addSubscribers()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                
            }
            .padding(.trailing, 10)
            .frame(maxWidth: UIScreen.main.bounds.width / 3, maxHeight: .infinity, alignment: .trailing)
            
            
            
        }
        .frame(height: 30, alignment: .center)
        .foregroundColor(.black)
        .font(.caption)
    }
    
    //MARK: Coin row
    @ViewBuilder private func coinRowView(coin: CoinModel)-> some View{
        
        VStack{
            CoinRowView(coin: coin, showHoldingsColumn: false)
            
        }
    }
    
    //MARK: Coin list view
    @ViewBuilder private var coinListView: some View{
        List{
            ForEach(vm_homeview.allCoins){coin in
                //CoinRowView(coin: coin, showHoldingsColumn: false)
                coinRowView(coin: coin)
                    .listRowInsets(EdgeInsets(top: 7, leading: 2, bottom: 7, trailing: 7))
            }
        }
        .listStyle(.plain)
        .padding(.bottom, 1)
    }
    
    @ViewBuilder private func globalItem(title: String, value: Int)-> some View{
        HStack(spacing: 1){
            Text(title + ": ")
            Text("\(value)")
                .foregroundColor(.blue)
        }
    }
}
