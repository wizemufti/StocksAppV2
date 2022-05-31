//
//  UserDefaultsManager.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/28/22.
//

import Foundation

final class UserDefaultsManager {
    
    // used to save our key
    private static let symbolKey = "SYMBOL_KEY"
    
    // variable savedSymbols of type string stored in an array
    var savedSymbols = [String]()
    
    // new instance of our class called shared
    static let shared = UserDefaultsManager()
    
    // call get functio0n
    private init() {
        get()
    }
    
    // getter function
    func get() {
        if let saved = UserDefaults.standard.array(forKey: Self.symbolKey) as? [String] {
            savedSymbols = saved
        }
    }
    
    // setter function (needed since we have a getter function)
    func set(symbol: String) {
        savedSymbols.append(symbol)
        UserDefaults.standard.set(self.savedSymbols, forKey: Self.symbolKey)
    }
}
