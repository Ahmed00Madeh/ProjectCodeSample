//
//  Helpers.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

func timeFrom(seconds: Double) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "mm:ss"
    return dateFormatter.string(from: Date.init(timeIntervalSinceReferenceDate: TimeInterval(seconds)))
}

func randomString(length: Int = 20) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
var appVersion: String {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
}
