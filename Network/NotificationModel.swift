//
//  NotificationModel.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 13/06/2022.
//

import ObjectMapper

class NotificationModel: BaseObject {

    var title = ""
    var date = Date()
    var content = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        title <- map["title"]
        date <- (map["date"], DateTransform())
        content <- map["content"]
    }
    
}
