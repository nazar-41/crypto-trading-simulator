//
//  ContentView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 24/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{

            tabItemView(view: HomeView(), label: "Portfolio", icon: "cart.fill")
            
            tabItemView(view: MarketView(), label: "Market", icon: "chart.line.uptrend.xyaxis")
            
            tabItemView(view: TradeView(), label: "Trade", icon: "bitcoinsign")
                        
            tabItemView(view: ExchangeListView(), label: "Exchanges", icon: "e.circle.fill")
            
//            tabItemView(view: Coin360View(), label: "coin360", icon: "globe")
//
//            tabItemView(view: Text("News"), label: "News", icon: "newspaper")
//
//            tabItemView(view: Text("Profile"), label: "Profile", icon: "person")
//
//            tabItemView(view: CreatorView(), label: "Creator", icon: "applelogo")
//

        
        }
        .accentColor(.orange)


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView{
    @ViewBuilder private func tabItemView(view: some View, label: String, icon: String)-> some View{
        view
            .tabItem {
                Label(label, systemImage: icon)
            }
    }
}
