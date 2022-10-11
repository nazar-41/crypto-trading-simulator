//
//  ExchangeLIstView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 06/10/2022.
//

import SwiftUI

struct ExchangeListView: View {
  
    @EnvironmentObject private var vm_exchangeListView: VM_ExchangeListView
    @EnvironmentObject private var vm_homeView: VM_HomeView
    
    let columnWidth: CGFloat = 130 //UIScreen.main.bounds.width / 3
    
    
    init(){
        //print("\n exchange list here: \(vm_exchangeListView.allExchanges) \n")
    }
    
 //   @State private var searchText: String = ""
    var body: some View {
        VStack {
            SearchBarView(searchBarText: $vm_exchangeListView.searchBarText, placeholderText: "Binance")
            

            List{
                ForEach(vm_exchangeListView.allExchanges){exchange in
                    ExchangeRowView(exchange: exchange, btcPrice: vm_homeView.btcPrice)
                        .listRowInsets(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                }
            }
            .listStyle(.plain)
            .padding(.bottom, 1)

        }
        .padding(.bottom, 1)
    }
}

struct ExchangeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeListView()
            .environmentObject(dev.vm_exchangeListView)
            .environmentObject(dev.vm_homeview)
    }
}


extension ExchangeListView{
    @ViewBuilder private var exchangeStatisticsHeader: some View{
        
        HStack{
            Text("Exchange score")
                .frame(width: 100)
            
            Text("Valume 24h")
                .frame(width: columnWidth, alignment: .trailing)
            
            Text("Country")
                .frame(width: columnWidth, alignment: .trailing)
            
            Text("Year established")
                .frame(width: columnWidth, alignment: .trailing)
            
            Text("Website")
                .frame(width: columnWidth, alignment: .trailing)
            
            
        }
        .frame(maxWidth: .infinity)
        .font(.caption)
    }
}
