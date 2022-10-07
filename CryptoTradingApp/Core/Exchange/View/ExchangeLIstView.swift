//
//  ExchangeLIstView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 06/10/2022.
//

import SwiftUI

struct ExchangeLIstView: View {
  
    @EnvironmentObject private var vm_exchangeListView: VM_ExchangeListView
    
    let columnWidth: CGFloat = 130 //UIScreen.main.bounds.width / 3

    
    init(){
        //print("\n exchange list here: \(vm_exchangeListView.allExchanges) \n")
    }
    
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            SearchBarView(searchBarText: $searchText)
            


            
            ScrollView(showsIndicators: false){
               // ForEach(exchangeList){ exchange in
                    HStack(spacing: 0){
                        VStack(spacing: 0){
                            ForEach(vm_exchangeListView.allExchanges){exchange in
                                ExchangeRowNameView(name: exchange.name ?? "", image: nil, rank: exchange.trustScoreRank ?? 0)
                                    .frame(height: 55)
                                    .padding(.trailing, 10)

                                
                                Divider()
                            }
                        }
                        .padding(.top, 25)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            exchangeStatisticsHeader
                            
                            VStack(spacing: 0){
                                ForEach(vm_exchangeListView.allExchanges){exchange in
                                    ExchangeRowStatisticsView(testData: exchange)
                                        .frame(height: 55)
                                    
                                    Divider()
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                
                Divider()
               // }
            }
            .padding(.top)
            .listStyle(.plain)
        }
        .padding(.bottom, 1)
    }
}

struct ExchangeLIstView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeLIstView()
            .environmentObject(dev.vm_exchangeListView)
    }
}


extension ExchangeLIstView{
    @ViewBuilder private var exchangeStatisticsHeader: some View{
        
        HStack{
            Text("Exchange score")
                .frame(width: 100)
            
            Text("Valume 24h")
                .frame(width: columnWidth, alignment: .trailing)
            
            Text("Weekly visits")
                .frame(width: columnWidth, alignment: .trailing)
            
            
        }
        .frame(maxWidth: .infinity)
        .font(.caption)
    }
}
