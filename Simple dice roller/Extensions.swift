//
//  Extensions.swift
//  Simple dice roller
//
//  Created by Brady Robshaw on 8/26/22.
//

import Foundation

extension Collection where Iterator.Element: Numeric {
    func sum() -> Iterator.Element {
        var sum: Iterator.Element = 0
        
        for number in self {
            sum += number
        }
        
        return sum
    }
}
