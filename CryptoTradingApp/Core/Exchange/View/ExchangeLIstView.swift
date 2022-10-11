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
    
    let columnWidth: CGFloat = 130
    
    var body: some View {
        VStack {
            SearchBarView(searchBarText: $vm_exchangeListView.searchBarText, placeholderText: "Binance")
                .padding(.bottom, 10)
            
            exchangeStatisticsHeader
            

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
        
        VStack{
            HStack{
                Text("Name")
                    .frame(width: 120, alignment: .leading)
                
                Spacer()
                
                Text("Exchange Rank")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.leading, 35)
                    
                Spacer()
                
                Text("Volume 24h")
                    .frame(width: 120, alignment: .trailing)

                
            }
            .padding(.horizontal, 7)
            .foregroundColor(.gray)
            .font(.caption)
        }

    }
}
