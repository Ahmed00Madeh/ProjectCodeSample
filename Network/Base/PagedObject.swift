//
//  KPagedObject.swift
//
//  Created by Ahmed Madeh.
//

import ObjectMapper

class PagedObject<T: BaseObject>: Mappable {
    
    var items: [T] = []
    var totalCount = 0
    var skip: Int { return items.count }
    var pageSize = 16
    var nextPage: Int {
           return Int(items.count / pageSize) + 1
    }
    init() { }
    required init?(map: Map) { }
    func mapping(map: Map) {
        items <- map["data"]
        totalCount <- map["paginate.total"]
        pageSize <- map["paginate.perPage"]
    }
    func hasNext(_ indexPath: IndexPath) -> Bool {
        return items.count < totalCount && indexPath.row == items.count - 1
    }
    
    func append(_ model: PagedObject<T>) {
        items.append(contentsOf: model.items)
        totalCount = model.totalCount
        pageSize = model.pageSize
    }
}
