//
//  PickerObject.swift
//
//  Created by Ahmed Madeh.
//

//import ObjectMapper
//import PromiseKit
//
//class PickerObject: BaseObject {
//    
//    var name = ""
//    var isSelected = false
//    
//    convenience init(id: Int, name: String) {
//        self.init()
//        self.id = id
//        self.name = name
//    }
//    
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//        id <- map["id"]
//        name <- map["name"]
//    }
//
//}
//
//extension Array where Element: PickerObject {
//    func asPromise() -> Promise<Self> {
//        return .value(self)
//    }
//}
