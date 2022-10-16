//
//  HomeVIew.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 24/09/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm_homeview: VM_HomeView
    
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack{
                
                headerCardView
                
                listTitleView
                
                if vm_homeview.portfolioCoins.isEmpty{
                    noHoldingsView
                }else{
                    coinListView
                }

            }
            .padding(.horizontal, 10)
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
            .padding()
            
        }
        .frame(height: 150)
    }
    
    //MARK: List header view
    @ViewBuilder private var listTitleView:  some View{
        HStack(spacing: 2){
            
            Text("Crypto")
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            //Text("Holdings")
            Label("Holdings", systemImage: "arrowtriangle.down.fill")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            HStack {
                Text("Price")

                Button {
                    vm_homeview.addSubscribers()
                    print("data refreshed")
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
    @ViewBuilder private func coinRowView(coin: CoinModel, showHoldinsColumn: Bool)-> some View{
            NavigationLink {
                Text(coin.name)
            } label: {
                VStack{
                    HStack {
                        CoinRowView(coin: coin, showHoldingsColumn: showHoldinsColumn)
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
//        ScrollView{
//            VStack{
//                ForEach(vm_homeview.portfolioCoins){coin in
//                    //CoinRowView(coin: coin, showHoldingsColumn: false)
//                    //coinRowView(coin: coin, showHoldinsColumn: true)
//                    PortfolioCoinRowView(coin: coin)
//                }
//            }
//        }
//        .frame(height: UIScreen.main.bounds.height * 0.7)
        
      //  VStack{
            List{
                ForEach(vm_homeview.portfolioCoins){coin in
                    PortfolioCoinRowView(coin: coin)
                        .listRowInsets(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                }
            }
        //    .border(.red, width: 10)
       // }
                .frame(height: UIScreen.main.bounds.height * 0.7)
                .listStyle(.plain)

    }
    
    //MARK: No holdings view
    @ViewBuilder private var noHoldingsView: some View{
        VStack{
            Image(systemName: "bonjour")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundColor(.orange)
            
            Text("No holdings")
                .font(.headline)
                .padding(.top)
        }
        .padding(.top, 100)
    }
}


struct HomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.vm_homeview)
            .accentColor(.orange)
    }
}

