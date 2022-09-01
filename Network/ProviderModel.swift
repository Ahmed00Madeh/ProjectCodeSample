//
//  ProviderModel.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 25/05/2022.
//

import ObjectMapper

final class ProviderModel: BaseObject {
    
    var name = ""
    var email = ""
    var phone = ""
    var desc = ""
    var location = AddressModel()
    var category = CategoryModel()
    var logo = ""
    var cover = ""
    var coverImages = [String]()
    var offersCount = 0
    var facebook = ""
    var instagram = ""
    var twitter = ""
    var youtube = ""
    var snapchat = ""
    var tiktok = ""
    var phone2 = ""
    var country = CountryModel()
    var rates = [RateModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        desc <- map["desc"]
        location <- map["location"]
        category <- map["category"]
        logo <- map["logo"]
        cover <- map["cover"]
        coverImages <- map["cover_images"]
        offersCount <- map["offers_count"]
        facebook <- map["facebook"]
        instagram <- map["instagram"]
        twitter <- map["twitter"]
        youtube <- map["youtube"]
        snapchat <- map["snapchat"]
        tiktok <- map["tiktok"]
        phone2 <- map["phone2"]
        country <- map["country"]
        rates <- map["rates"]
    }
    
}
