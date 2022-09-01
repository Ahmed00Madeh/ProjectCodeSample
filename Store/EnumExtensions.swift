//
//  EnumExtensions.swift
//
//  Created by Ahmed Madeh.
//
//import PromiseKit
//protocol StringRepresentable { var title: String { get } }
//
//extension CaseIterable where Self:  StringRepresentable & RawRepresentable, RawValue == Int {
//   static func asPromise() -> Promise<[PickerObject]> {
//        var temp: [PickerObject] = []
//        for _case in Self.allCases {
//            temp.append(.init(id: _case.rawValue, name: _case.title))
//        }
//        return .value(temp)
//    }
//}
//
//extension Gender: StringRepresentable {
//    var title: String {
//        switch self {
//        case .male:
//            return "Male".localized
//        case .female:
//            return "Female".localized
//        }
//    }
//    
//}
