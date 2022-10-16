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
    
    @State private var showCoinList: Bool = false
    @State private var showAlert: Bool = false

    @State var passedCoin: CoinModel?
    
    @State private var alertInfo: AlertModel?
    
    var tradeCoin: CoinModel{
        if let passedCoin = passedCoin{
            return passedCoin
        }else if let defaultCoin = vm_homeView.btcModel{
            return defaultCoin
        }
        
        return EmptyCoinModel.emptyCoinModel
    }
    
    var body: some View {
        VStack(spacing: 0){
            headerTradeTypeView
            
            ScrollView(showsIndicators: false){
                
                selectCoinView(coin: tradeCoin)
                
                coinName(coin: tradeCoin)
                
                liveMarketSimulator(coin: tradeCoin)
                
                orderType
                
                stableOptimalPriceButton
                
                enterAmount()
                
                buySellButtons()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .padding(.bottom, 1)
        .sheet(isPresented: $showCoinList) {
            SelectTradeCoinSheet(passedCoin: $passedCoin)
                .environmentObject(vm_homeView)
        }
        .alert(item: $alertInfo) { info in
            Alert(title: Text(info.title), message: Text(info.message), dismissButton: .default(Text("OK")))
        }
 
    }
    
    
    private func buyAmount()-> String {
        let buyAmount = vm_tradeview.buyAmount
        
        guard !buyAmount.isEmpty,
              let quantity = Double(buyAmount) else {return ""}
        
 
        
        return (quantity / tradeCoin.currentPrice).asDoubleWith6Decimals() + tradeCoin.symbol.uppercased()
    }
    
    private func sellAmount()-> String {
        let sellAmount = vm_tradeview.sellAmount
        
        guard !sellAmount.isEmpty,
              let quantity = Double(sellAmount) else {return ""}
        
 
        
        return (quantity / tradeCoin.currentPrice).asDoubleWith6Decimals() + tradeCoin.symbol.uppercased()
    }
}

struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        TradeView(passedCoin: dev.vm_homeview.btcModel)
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
    @ViewBuilder private func selectCoinView(coin: CoinModel)-> some View{
        HStack{
            Image(systemName: "list.triangle")
                .font(.system(size: 20, weight: .medium))
            
            
            Button {
                showCoinList = true
            } label: {
                Text("\(coin.symbol.uppercased())/USDT")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                
            }
            
            Text((coin.priceChangePercentage24H ?? 0).asPercentString())
                .foregroundColor(coin.priceChangePercentage24H ?? 0 > 0 ? .green : .red)
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
    @ViewBuilder private func coinName(coin: CoinModel)-> some View{
        VStack{
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .foregroundColor(.green)
                .font(.system(size: 25, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.leading, 10)
        }
        
    }
    
    //MARK: active market simulator
    @ViewBuilder private func liveMarketSimulator(coin: CoinModel)-> some View{
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
                            Text("\(Float.random(in: 0..<1))")
                                .frame(alignment: .leading)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 3){
                        
                        Text("Price")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        ForEach(vm_tradeview.getRandomCoinPriceArray(price: coin.currentPrice).reversed(), id: \.self){price in
                            
                            Text(price.asDoubleWith3Decimals())
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
                        
                        ForEach(vm_tradeview.getRandomCoinPriceArray(price: coin.currentPrice), id: \.self){price in
                            
                            Text(price.asDoubleWith3Decimals())
                                .frame(alignment: .leading)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                    }
                    
                    
                    Spacer()

                    
                    
                    VStack(alignment: .trailing, spacing: 3){
                        
                        Text("Amount")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        ForEach(1..<6){_ in
                            Text("\(Float.random(in: 0..<1))")
                                .frame(alignment: .leading)
                        }
                    }
                    
                    
                    VStack(alignment: .trailing, spacing: 3){
                        
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
        VStack {
            HStack(spacing: 20){
                Text(buyAmount())
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                 //   Spacer()
                
                
                Text(sellAmount())
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

            }
            .font(.caption2)
            .foregroundColor(.gray)
            
            HStack(spacing: 20){
                VStack {
                    VStack{
                        HStack{
                            TextField("Buy amount", text: $vm_tradeview.buyAmount)
                            //.frame(width: 100)
                                .keyboardType(.decimalPad)
                            
                            Text("USDT")
                            
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
                            
                            Text("USDT")
                            
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
        }
        .padding(.horizontal, 10)
        .padding(.top, 20)

    }
    
    @ViewBuilder private func buySellButtons()-> some View{
        HStack(spacing: 20){
            ZStack{
                Color.green
                
                Button {
                    guard let coin = passedCoin,
                          !vm_tradeview.buyAmount.isEmpty else {return}
                    
                        vm_homeView.updatePortfolio(type: .buy, coin: coin, amount: Double(vm_tradeview.buyAmount) ?? 0)
                    
                    alertInfo = AlertModel(title: "Success 🎉", message: "Coin bought, check your portfolio")

                } label: {
                    ZStack{
                        Color.green
                        Color.white.opacity(0.3)
                        
                        if let coin = passedCoin{
                            Text("Buy \(coin.symbol.uppercased())")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                    .frame(height: 35)
                }
                .disabled(passedCoin == nil)

            }
            .frame(height: 35)
            
            ZStack{
                Color.green
                
                Button {
                    guard let coin = passedCoin,
                          !vm_tradeview.sellAmount.isEmpty else {return}
                    
                        vm_homeView.updatePortfolio(type: .sell, coin: coin, amount: Double(vm_tradeview.sellAmount) ?? 0)
                    
                    alertInfo = AlertModel(title: "Success 🎉", message: "Coin sold, check your portfolio")
                    
                } label: {
                    ZStack{
                        Color.red
                        Color.white.opacity(0.3)

                        if let coin = passedCoin{
                            Text("Sell \(coin.symbol.uppercased())")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
   
                        
                    }
                    .frame(height: 35)
                }
                .disabled(passedCoin == nil)

            }
            .frame(height: 35)
            
        }
        .padding(.horizontal, 10)
        .padding(.top)
        
    }
    
}
