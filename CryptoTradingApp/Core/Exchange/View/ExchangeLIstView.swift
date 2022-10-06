//
//  ExchangeLIstView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 06/10/2022.
//

import SwiftUI

struct ExchangeLIstView: View {
    let exchangeList: [ExchangeModel] = [DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,                            DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,                            DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,
                                         DeveloperPreview.instance.exchange,]
    
    let columnWidth: CGFloat = 130 //UIScreen.main.bounds.width / 3

    
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            SearchBarView(searchBarText: $searchText)
            


            
            ScrollView(showsIndicators: false){
               // ForEach(exchangeList){ exchange in
                    HStack(spacing: 0){
                        VStack(spacing: 0){
                            ForEach(exchangeList){exchange in
                                ExchangeRowNameView(name: exchange.name, image: nil, rank: exchange.rank)
                                    .frame(height: 50)
                                    .padding(.trailing)

                                
                                Divider()
                            }
                        }
                        .padding(.top, 25)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            exchangeStatisticsHeader
                            
                            VStack(spacing: 0){
                                ForEach(exchangeList){exchange in
                                    ExchangeRowStatisticsView(testData: exchange)
                                        .frame(height: 50)
                                    
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
    }
}

struct ExchangeLIstView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeLIstView()
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
