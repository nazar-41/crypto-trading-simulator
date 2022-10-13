//
//  TradeView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 12/10/2022.
//

import SwiftUI

struct TradeView: View {
    @StateObject private var vm_tradeview = VM_TradeView()
    
    @EnvironmentObject private var vm_homeView: VM_HomeView
    
    
    
    var body: some View {
        VStack(spacing: 0){
            headerTradeTypeView
            
            ScrollView(showsIndicators: false){
                
                selectCoinView()
                
                coinName()
                
                liveMarketSimulator()
                
                orderType
                
                stableOptimalPriceButton
                
                enterAmount()
                
                buySellButtons()
                
            }
        }
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $vm_tradeview.showCoinList) {
            SelectTradeCoinSheet()
                .environmentObject(vm_homeView)
        }
 
    }
    
}

struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        TradeView()
            .environmentObject(VM_HomeView())
    }
}


extension TradeView{
    //MARK: top header, spot trading
    @ViewBuilder private var headerTradeTypeView: some View{
        ZStack(alignment: .bottom){
            Color.gray.opacity(0.1)
            Text("Spot")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .font(.system(size: 17, weight: .bold))
            
        }
        .frame(height: 80)
        .frame(width: UIScreen.main.bounds.width)
    }
    
    //MARK: select coin view
    @ViewBuilder private func selectCoinView()-> some View{
        HStack{
            Image(systemName: "list.triangle")
                .font(.system(size: 20, weight: .medium))
            
            
            Button {
                vm_tradeview.showCoinList = true
            } label: {
                Text("BTC/USDT")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                
            }
            
            Text("+23%")
                .foregroundColor(.green)
                .font(.subheadline)
            
            
            Spacer()
            
            
            //fake buttons
            HStack{
                ZStack{
                    Color.gray.opacity(0.2)
                    Text("200x")
                        .font(.caption)
                }
                .frame(width: 40, height: 20)
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.subheadline)
                
                Image(systemName: "ellipsis")
                    .font(.subheadline)
            }
            
            
        }
        .padding(10)
        
    }
    
    //MARK: coin name
    @ViewBuilder private func coinName()-> some View{
        VStack{
            Text("2342.24")
                .foregroundColor(.green)
                .font(.system(size: 25, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.leading, 10)
        }
        
    }
    
    //MARK: active market simulator
    @ViewBuilder private func liveMarketSimulator()-> some View{
        VStack{
            HStack(spacing: 0){
                HStack{
                    VStack(alignment: .leading, spacing: 3){
                        
                        Text("Buy")
                            .foregroundColor(.gray)
                        
                        ForEach(1..<6){i in
                            Text("\(i)")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 3){
                        
                        Text("Amount")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        ForEach(1..<6){_ in
                            Text("\(Float.random(in: 0..<2))")
                                .frame(alignment: .leading)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 3){
                        
                        Text("Price")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        ForEach(1..<6){_ in
                            let random = String(format: "%.2f", Double.random(in: 19200..<20000)) //Double.random(in: 19200..<20000)
                            
                            Text(random)
                                .frame(alignment: .leading)
                        }
                    }
                }
                .font(.caption)
                .foregroundColor(.black.opacity(0.5))
                .padding(10)
                .background(.green.opacity(0.15))
                
                
                
                
                HStack{
                    VStack(alignment: .leading, spacing: 3){
                        
                        Text("Price")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        ForEach(1..<6){_ in
                            let random = String(format: "%.2f", Double.random(in: 19200..<20000)) //Double.random(in: 19200..<20000)
                            
                            Text(random)
                                .frame(alignment: .leading)
                        }
                    }
                    
                    
                    
                    
                    VStack(alignment: .trailing, spacing: 3){
                        
                        Text("Amount")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        ForEach(1..<6){_ in
                            Text("\(Float.random(in: 0..<2))")
                                .frame(alignment: .leading)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2){
                        
                        Text("Sell")
                            .foregroundColor(.gray)
                        
                        ForEach(1..<6){i in
                            Text("\(i)")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .font(.caption)
                .foregroundColor(.black.opacity(0.5))
                .padding(10)
                .background(.red.opacity(0.15))
            }
        }
        
    }
    
    //MARK: order type view
    @ViewBuilder private var orderType: some View{
        HStack{
            Image(systemName: "questionmark.circle")
            
            Text("Market order")
            
            Spacer()
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 8))
                .foregroundColor(.gray)
        }
        .font(.system(size: 12, weight: .regular))
        .padding(4)
        .border(.gray.opacity(0.5), width: 0.5)
        .padding(.horizontal, 10)
        .padding(.top)
    }
    
    //MARK: fake price buttons (stable optimal price)
    @ViewBuilder private var stableOptimalPriceButton: some View{
        HStack(spacing: 20){
            ZStack{
                Color.gray.opacity(0.1)
                Text("Optimal price")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(height: 30)
            
            ZStack{
                Color.gray.opacity(0.1)
                Text("Optimal price")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(height: 30)
        }
        .padding(.horizontal, 10)
        .padding(.top)
    }
    
    //MARK: amount percentage button
    @ViewBuilder private func amountPercentageButton(type: BuySellEnum, percentage: Int, action: @escaping () -> Void)-> some View{
        Button {
            action()
        } label: {
            Text("\(percentage)%")
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 5)
        .border(.gray.opacity(0.3), width: 0.5)
    }
    
    @ViewBuilder private func enterAmount()-> some View{
        HStack(spacing: 20){
            VStack {
                VStack{
                    HStack{
                        TextField("Buy amount", text: $vm_tradeview.buyAmount)
                        //.frame(width: 100)
                            .keyboardType(.decimalPad)
                        
                        Text("BTC")
                        
                    }
                    .foregroundColor(.black.opacity(0.7))
                    .font(.caption)
                    .padding(5)
                    .onTapGesture { UIApplication.shared.endEditing() }
                    
                    HStack(spacing: 0){
                        amountPercentageButton(type: .buy, percentage: 25) {}
                        amountPercentageButton(type: .buy, percentage: 50) {}
                        amountPercentageButton(type: .buy, percentage: 75) {}
                        amountPercentageButton(type: .buy, percentage: 100) {}
                        
                    }
                    .foregroundColor(.gray.opacity(0.5))
                    .font(.caption)
                    
                }
                .border(.gray.opacity(0.2))
                
                HStack(spacing: 0){
                    Text("Available")
                    Image(systemName: "questionmark.circle")
                    
                    Text("50,000.0000 USDT")
                        .foregroundColor(.black)
                        .padding(.leading, 5)
                    
                    
                    Spacer()
                }
                .foregroundColor(.gray)
                .font(.system(size: 10, weight: .regular))
            }
            
            VStack {
                VStack{
                    HStack{
                        TextField("Sell amount", text: $vm_tradeview.sellAmount)
                        //                                .frame(width: 100)
                            .keyboardType(.decimalPad)
                        
                        Text("BTC")
                        
                    }
                    .foregroundColor(.black.opacity(0.7))
                    .font(.caption)
                    .padding(5)
                    .onTapGesture { UIApplication.shared.endEditing() }
                    
                    HStack(spacing: 0){
                        
                        amountPercentageButton(type: .sell, percentage: 25) {}
                        amountPercentageButton(type: .sell, percentage: 50) {}
                        amountPercentageButton(type: .sell, percentage: 75) {}
                        amountPercentageButton(type: .sell, percentage: 100) {}
                        
                        
                    }
                    .foregroundColor(.gray.opacity(0.5))
                    .font(.caption)
                    
                    
                }
                .border(.gray.opacity(0.2))
                
                HStack(spacing: 0){
                    Text("Available")
                    Image(systemName: "questionmark.circle")
                    
                    Text("0.00000000 USDT")
                        .foregroundColor(.black)
                        .padding(.leading, 5)
                    
                    
                    Spacer()
                }
                .foregroundColor(.gray)
                .font(.system(size: 10, weight: .regular))
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 20)
    }
    
    @ViewBuilder private func buySellButtons()-> some View{
        HStack(spacing: 20){
            ZStack{
                Color.green
                
                Button {
                    //
                } label: {
                    ZStack{
                        Color.green
                        Color.white.opacity(0.3)
                        
                        Text("Buy BTC")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .frame(height: 35)
                }

            }
            .frame(height: 35)
            
            ZStack{
                Color.green
                
                Button {
                    //
                } label: {
                    ZStack{
                        Color.red
                        Color.white.opacity(0.3)

                        
                        Text("Sell BTC")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .frame(height: 35)
                }

            }
            .frame(height: 35)
            
        }
        .padding(.horizontal, 10)
        
    }
    
}
