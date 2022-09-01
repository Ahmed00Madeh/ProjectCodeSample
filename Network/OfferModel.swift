//
//  OfferModel.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 25/05/2022.
//

import ObjectMapper

final class OfferModel: BaseObject {
    
    var name = ""
    var image = ""
    var images = [String]()
    var date = ""
    var startOfferDate = ""
    var endOfferDate = ""
    var priceAfter = ""
    var cost = ""
    var provider = ProviderModel()
    var desc = ""
    var rates = [RateModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        image <- map["image"]
        images <- map["images"]
        date <- map["date"]
        startOfferDate <- map["start_offer_date"]
        endOfferDate <- map["end_offer_date"]
        priceAfter <- map["price_after"]
        cost <- map["cost"]
        provider <- map["provider"]
        desc <- map["description"]
        rates <- map["rates"]
    }
    
}
