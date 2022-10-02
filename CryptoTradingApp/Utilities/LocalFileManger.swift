//
//  LocalFileManger.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 02/10/2022.
//

import Foundation
import SwiftUI


class LocalFileManger{
    static let instance = LocalFileManger()
    private init(){}
    
    
    //MARK: save image
    func saveImage(image: UIImage, folderName: String, imageName: String){
        
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.pngData(),
              let url = getImageURL(imageName: imageName, folderName: folderName) else {
                print("invalid image data")
                return
        }
        
        do {
            try data.write(to: url)
        } catch {
            print("error while saving image: \(error.localizedDescription)")
        }
    }
    
    // MARK: get image
    func getImage(folderName: String, imageName: String)-> UIImage?{
        guard let url = getImageURL(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            print("no image")
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    
    //MARK: create folder for images
    private func createFolderIfNeeded(folderName: String){
        guard let url = getFolderURL(folderName: folderName) else{return}
        
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("new directory created")
            } catch {
                print("error creating directory: \(error)")
            }
        }
    }
    
    
    //MARK: get folder url
    private func getFolderURL(folderName: String)-> URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            print("error getting folder path")
            return nil
        }
        
        return url.appendingPathComponent(folderName)
    }
    
    //MARK: get image url
    private func getImageURL(imageName: String, folderName: String)-> URL?{
        guard let folderURL = getFolderURL(folderName: folderName) else{
            print("invalid folder name")
            return nil
        }
        
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
