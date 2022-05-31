//
//  Array+Extensions.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/28/22.
//

import Foundation

extension Array where Element: Hashable {
    
    // function for getting difference in each array
    func difference(from other: [Element]) -> [Element] {
        
        let thisSet = Set(self)                                 // set operation for self
        let otherSet = Set(other)                               // set operation for other
        return Array(thisSet.symmetricDifference(otherSet))     // gives us difference between the 2 arrays
    }
}
