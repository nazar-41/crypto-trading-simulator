//
//  PortfolioDataService.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 15/10/2022.
//

import Foundation
import CoreData


class PortfolioDataService{
    
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    
    init(){
        container = NSPersistentContainer(name: containerName)
        context = container.viewContext
        
        container.loadPersistentStores { _, error in
            if let error = error{
                print("\n error loading core data: \(error)")
            }
            
            print("success creating creating container")

            
            self.getPortfolio()

        }
        
        
    }
    
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
           savedEntities = try context.fetch(request)

        } catch {
            print("\n error fetching core data: \(error)")
        }
    }
    
    func buyCoin(coin: CoinModel, amount: Double){
        guard amount > 0 else {return}
        
        if let coinEntity = isCoinBoughtAlready(coinID: coin.id){
        //   guard let coinEntity = savedEntities.first(where: {($0.coinID ?? "") == coin.id}) else {return}
            
            updateCoin(entity: coinEntity, amount: amount)
            
        }else{
            let entity = PortfolioEntity(context: context)
            entity.coinID = coin.id
            entity.price = coin.currentPrice
            entity.amount = amount
            
            print("\n new coin added")
            
        }
        
        // if you wanna just update your database use saveData() function - this is for large database
        // or if you wanna reload all data again use applyChanges() function - this is for small database
        applyChanges()
    }
    
//    func sellCoin(entity: PortfolioEntity, amount: Double){
//        guard amount > 0 else {return}
//
//        guard let coinID = entity.coinID,
//              let coinEntity = isCoinBoughtAlready(coinID: coinID) else {
//
//            print("coin doesn't exist to sell")
//            return
//        }
//
//        guard entity.amount >= amount else{
//            print("\n your selling amount is bigger than available")
//            return
//        }
//
//        if amount > entity.amount{
//            print("\n your selling amount of \(entity.coinID) is bigger than available")
//        } else if amount == entity.amount{
//            removeCoin(entity: entity)
//            print("\n \(entity.coinID) selled 100%")
//        }
////        else{
////            updateCoin(entity: coinEntity, amount: amount)
////        }
//        updateCoin(entity: entity, amount: amount)
//
//
//    }
    
    func sellCoin(entity: PortfolioEntity, amount: Double){
        guard amount > 0 else {
            print("selling amount must be bigger than 0")
            return
        }
        
        guard let entity = isCoinBoughtAlready(coinID: entity.coinID ?? ".") else {
            print("selling coin is not available in your portfolio")
            return
        }
        
//        guard entity.amount > amount else{
//            print("\n your selling amount is bigger than available")
//            return
//        }
        
        if amount < entity.amount{
            updateCoin(entity: entity, amount: entity.amount - amount)
        }else if amount == entity.amount{
            removeCoin(entity: entity)
        }
        
        
        
    }
    
    
    
    private func updateCoin(entity: PortfolioEntity, amount: Double){
        entity.amount = amount
        
        print("\n coin updated successfully")
        
        applyChanges()
    }
    
    private func removeCoin(entity: PortfolioEntity){
        context.delete(entity)
        
        print("\n coin removed successfully")
        
        applyChanges()
    }
    
    
    private func saveData(){
        do {
            try context.save()
        } catch {
            print("error saving core data: \(error)")
        }
    }
    
    private func applyChanges(){
        saveData()
        
        getPortfolio()
    }
    
    private func isCoinBoughtAlready(coinID: String)-> PortfolioEntity?{
        if let coinEntity = savedEntities.first(where: {$0.coinID == coinID}){
            return coinEntity
        }
        return nil
    }
    
}
