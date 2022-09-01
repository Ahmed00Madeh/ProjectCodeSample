//
//  AddressModel.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 25/05/2022.
//

import ObjectMapper

final class AddressModel: BaseObject {
    
    var name = ""
    var lat = 0.0
    var long = 0.0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name", "address_name"]
        lat <- map["lat"]
        long <- map["long"]
    }
    
}
