//
//  BaseObject.swift
//
//  Created by Ahmed Madeh.
//

import ObjectMapper

class BaseObject: Mappable {
    var id = 0
    var specialityId = 0
    
    init() { }
    required init?(map: Map) { }
    func mapping(map: Map) {
        id <- map["id"]
        specialityId <- map["speciality_id"]
    }
}

protocol Storable {}
extension Storable where Self: Mappable {
    private static var key: String {
        return "Current" + String(describing: Self.self)
    }
    
    static var current: Self? {
        set {
            guard let value = newValue else {
                return Cache.removeObject(key: key)
            }
            Cache.set(object: value.toJSON(), forKey: key)
        } get {
            guard let json = Cache.object(key: key) as? [String: Any]  else {
                return .none
            }
            return Mapper().map(JSON: json)
        }
    }
    func store() {
        Self.current = self
    }
}
