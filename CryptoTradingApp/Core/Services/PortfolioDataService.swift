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
    private let entityName: String = "EntityName"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    
    init(){
        container = NSPersistentContainer(name: containerName)
        context = container.viewContext
        
        container.loadPersistentStores { _, error in
            if let error = error{
                print("\n error loading core data: \(error)")
            }
        }
        
        
        getPortfolio()
    }
    
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
           savedEntities = try context.fetch(request)
        } catch {
            print("\n error fetching core data: \(error)")
        }
    }
    
    private func buyCoin(coin: CoinModel, amount: Double){
        if isCoinBoughtAlready(coinID: coin.id){
           guard let coinEntity = savedEntities.first(where: {($0.coinID ?? "") == coin.id}) else {return}
            
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
   
    private func sellCoin(entity: PortfolioEntity, amount: Double){
        
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
    
    private func isCoinBoughtAlready(coinID: String)-> Bool{
        if savedEntities.first(where: {($0.coinID ?? "") == coinID}) != nil{
            return true
        }
        return false
    }
    
}
