//
//  VM_HomeView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 26/09/2022.
//

import Foundation
import Combine


class VM_HomeView: ObservableObject{
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchBarText: String = ""
    
   // @Published var btcPrice: Double?
    
    @Published var btcModel: CoinModel?
    
    @Published var globalMarketData: MarketDataModel?
    
    private let coinDataService = CoinDataService()
    private let globalMarketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }

    func addSubscribers(){
//        dataService.$allCoins
//            .sink {[weak self] receivedCoins in
//                guard let self = self else{return}
//
//                self.allCoins = receivedCoins
//            }
//            .store(in: &cancellables)
        
        //MARK: Updated all coins
        $searchBarText
            .combineLatest(coinDataService.$allCoins)
            //pause for 0.5 seconds
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedArray in
                guard let self = self else {return}
                self.allCoins = returnedArray
                
                self.getBtcPrice()
            }
            .store(in: &cancellables)
        
        //MARK: updates all exchanges
        globalMarketDataService.$marketData
            .sink {[weak self] receivedMarketData in
                guard let self = self else{return}
                self.globalMarketData = receivedMarketData
            }
            .store(in: &cancellables)
        
        //MARK: updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map{ (coinModels, portfolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else{ return nil}
                        let test = coin.updateHoldings(amount: entity.amount, boughtPrice: entity.price)
                        
                        return test
                    }
            }
            .sink {[weak self] returnedCoins in
                guard let self = self else {return}
                self.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    func updatePortfolio(type: BuySellEnum, coin: CoinModel, amount: Double){
        if type == .buy{
            portfolioDataService.buyCoin(coin: coin, amount: amount)
        }else if type == .sell{
            guard let entity = portfolioDataService.savedEntities.first(where: {$0.coinID == coin.id}) else {return}
            portfolioDataService.sellCoin(entity: entity, amount: amount)
        }
    }
    
    
    private func filterCoins(text: String, startingCoins: [CoinModel])-> [CoinModel]{
        guard !text.isEmpty else { return startingCoins}
        
        let lowercasedText = text.lowercased()
        
        let filteredArray = startingCoins.filter { coin in
            return coin.id.lowercased().contains(lowercasedText) || coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText)
        }
        
        return filteredArray
    }
    
    private func getBtcPrice(){
        if let btcModel = allCoins.first(where: {$0.id == "bitcoin"}){
           // self.btcPrice = btcModel.currentPrice
            self.btcModel = btcModel
            print("btc price is: \(btcModel.currentPrice)")
        }else{
            print("invalid btc price")
        }
        
//        if let btcPrice = allCoins.filter({$0.id == "bitcoin"}).first{
//            self.btcPrice = btcPrice.currentPrice
//            print("btc price is: \(self.btcPrice)")
//        }else{
//            print("invalid btc price")
//        }
    }
}
