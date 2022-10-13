//
//  SelectCoinSheet.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 13/10/2022.
//

import SwiftUI

struct SelectTradeCoinSheet: View {
    @EnvironmentObject private var vm_homeView: VM_HomeView
    
    @StateObject private var vm_selectTradeCoinSheet = VM_SelectTradeCoinSheet()
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack{
            SearchBarView(searchBarText: $vm_selectTradeCoinSheet.searchBarText, placeholderText: "Bitcoin")
                .padding(.top)
            

            coinList()
            
            Spacer()
        }
    }
}

struct SelectTradeCoinSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelectTradeCoinSheet()
            .environmentObject(VM_HomeView())
    }
}

extension SelectTradeCoinSheet{
    @ViewBuilder private func coinList()-> some View{
        VStack{
            
            if let allCoins = vm_selectTradeCoinSheet.allCoins{
                
                List(allCoins) { coin in
                    
                    HStack(spacing: 10){
                        CoinImageView(coin: coin)
                            .frame(width: 30, height: 30)
                        
                        Text(coin.name)
                            .font(.system(size: 15, weight: .regular))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("selected coin: \(coin.id)")
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding(.top)
                .listStyle(.plain)
            }
        }
    }
}
