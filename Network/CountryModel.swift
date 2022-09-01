//
//  CountryModel.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 25/05/2022.
//

import ObjectMapper

final class CountryModel: BaseObject, Storable {
    
    var name = ""
    var image = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        image <- map["image"]
    }
    
}
