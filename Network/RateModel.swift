//
//  File.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 25/05/2022.
//

import ObjectMapper

final class RateModel: BaseObject {
    
    var user = UserModel()
    var rate = 0
    var comment = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        user <- map["user"]
        rate <- map["rate"]
        comment <- map["comment"]
    }
    
}
