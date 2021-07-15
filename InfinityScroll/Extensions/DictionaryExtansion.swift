//
//  DictionaryExtansion.swift
//  InfinityScroll
//
//  Created by Олег on 13.07.2021.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
