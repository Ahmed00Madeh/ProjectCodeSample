//
//  UserModel.swift
//  HsnVendorDiscount
//
//  Created by Ahmed Madeh on 17/04/2022.
//

import ObjectMapper

class UserModel: BaseObject, Storable {
    
    var name = ""
    var email = ""
    var avatar = ""
    var active = ""
    var token = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["data.name", "name"]
        email <- map["data.email", "email"]
        avatar <- map["data.avatar", "avatar"]
        active <- map["data.active", "active"]
        token <- map["api_token"]
    }
    
}
