//
//  MapExtentions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
import ObjectMapper

extension Map {
    public subscript(keys: String...) -> Map {
        for key in keys {
            let newKey = key.components(separatedBy: ".").first!.components(separatedBy: "[").first!
            if self.JSON[newKey] != nil && !(self.JSON[newKey] is NSNull)  {
                return self[key, delimiter: ".", ignoreNil: false]
            }
        }
        /// save key and value associated to it
        return self[keys.first!, delimiter: ".", ignoreNil: false]
    }
}

extension Mappable {
    func copy() -> Self {
        return self.newCopy()
    }
    
    private func newCopy<T: Mappable>() -> T {
        return Mapper<T>().map(JSON: toJSON())!
    }
}
