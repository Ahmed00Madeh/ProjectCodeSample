//
//  APIs.swift
//  HsnVendorDiscount
//
//  Created by Ahmed Madeh on 17/04/2022.
//

import PromiseKit
import ESNetworkManager
import Alamofire

final class APIs {
    
    class func login(email: String, password: String) -> Promise<UserModel> {
        let request = ESNetworkRequest("login")
        request.method = .post
        request.parameters = ["email": email,
                              "password": password]
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func register(name: String, email: String, password: String) -> Promise<UserModel> {
        let request = ESNetworkRequest("register")
        request.method = .post
        request.parameters = ["name": name,
                              "email": email,
                              "password": password]
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func updateUserImage(image: UIImage) -> Promise<String> {
        let request = ESNetworkRequest("profile")
        request.method = .post
        request.encoding = URLEncoding.default
        request.selections = [.key("data"), .key("avatar")]
        return NetworkManager.upload(data: .multipart(
            [.init(data: image.jpegData(compressionQuality: 0.5)!,
                   key: "avatar",
                   name: "avatar",
                   memType: "image/jpeg")
            ]), request: request) { progress in
            debugPrint("upload progress: \(progress)")
        }
    }
    
    class func updateUserInfo(name: String, email: String) -> Promise<UserModel> {
        let request = ESNetworkRequest("profile")
        request.method = .post
        request.parameters = ["name": name,
                              "email": email]
        return NetworkManager.execute(request: request)
    }
    
    class func listCategories(page: Int) -> Promise<PagedObject<CategoryModel>> {
        let request = ESNetworkRequest("categories?page=\(page)")
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func listProviders(countryId: Int, page: Int) -> Promise<PagedObject<ProviderModel>> {
        let request = ESNetworkRequest("providers?country_id=\(countryId)&page=\(page)")
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func listOffers(countryId: Int, page: Int) -> Promise<PagedObject<OfferModel>> {
        let request = ESNetworkRequest("offers?country_id=\(countryId)&page=\(page)")
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func listCountries() -> Promise<[CountryModel]> {
        let request = ESNetworkRequest("countries")
        return NetworkManager.execute(request: request)
    }
    
    class func contactUs(name: String, email: String, phone: String, message: String) -> Promise<Any> {
        let request = ESNetworkRequest("profile")
        request.method = .post
        request.parameters = ["name": name,
                              "email": email,
                              "phone": phone,
                              "message": message,
                              "type_id": 1]
        return NetworkManager.execute(request: request)
    }
    
    class func searchProviders(page: Int, keyword: String,
                               lat: Double, long: Double) -> Promise<PagedObject<ProviderModel>> {
        var path = "providers?page=\(page)"
        if lat != 0.0 {
            path += "&map_lat=\(lat)"
        }
        if long != 0.0 {
            path += "&map_lng=\(long)"
        }
        path += "&country_id=\(CountryModel.current?.id ?? 0)"
        let request = ESNetworkRequest(path)
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func getCategoryProviders(categoryId: Int, page: Int) -> Promise<PagedObject<ProviderModel>> {
        let request = ESNetworkRequest("search?page=\(page)")
        request.method = .post
        request.parameters = ["by": "providers",
                              "category_id": categoryId]
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func searchOffers(page: Int, keyword: String,
                            lat: Double, long: Double) -> Promise<PagedObject<OfferModel>> {
        var path = "offers?page=\(page)"
        path += "&name=\(keyword)"
        if lat != 0.0 {
            path += "&map_lat=\(lat)"
        }
        if long != 0.0 {
            path += "&map_lng=\(long)"
        }
        path += "&country_id=\(CountryModel.current?.id ?? 0)"
        let request = ESNetworkRequest(path)
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func rateOffer(rate: Double, comment: String, offerId: Int) -> Promise<Any> {
        let request = ESNetworkRequest("rate")
        request.method = .post
        request.parameters = ["model_id": offerId,
                              "model_type": "offers",
                              "comment": comment,
                              "rate": rate]
        return NetworkManager.execute(request: request)
    }
    
    class func loadNotifications(page: Int) -> Promise<PagedObject<NotificationModel>> {
        let request = ESNetworkRequest("notifications?page=\(page)")
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func getProviderOffers(providerId: Int, page: Int) -> Promise<PagedObject<OfferModel>> {
        let request = ESNetworkRequest("providers/\(providerId)/offers?page=\(page)")
        request.selections.removeAll()
        return NetworkManager.execute(request: request)
    }
    
    class func getOfferDetails(offerId: Int) -> Promise<OfferModel> {
        let request = ESNetworkRequest("offers/\(offerId)")
        return NetworkManager.execute(request: request)
    }
    
    class func deleteAccount() -> Promise<Any> {
        let request = ESNetworkRequest("profile/delete-account")
        return NetworkManager.execute(request: request)
    }
    
}
