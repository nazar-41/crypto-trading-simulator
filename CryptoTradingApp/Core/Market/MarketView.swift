//
//  MarketView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 27/09/2022.
//

import SwiftUI

struct MarketView: View {
    @EnvironmentObject private var vm_homeview: VM_HomeView
    
    var body: some View {
        ScrollView{
            VStack{
                listTitleView
                
                coinListView
            }
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
            NavigationLink {
                Text(coin.name)
            } label: {
                VStack{
                    HStack {
                        CoinRowView(coin: coin, showHoldingsColumn: false)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 11, weight: .bold))
                    }
                    .padding(.vertical, 4)

                    Divider()
                }
                .padding(.trailing, 5)
            }
        }

    
    //MARK: Coin list view
    @ViewBuilder private var coinListView: some View{
        ScrollView{
            VStack{
                ForEach(vm_homeview.allCoins){coin in
                    //CoinRowView(coin: coin, showHoldingsColumn: false)
                    coinRowView(coin: coin)
                }
            }
        }
    }
}
