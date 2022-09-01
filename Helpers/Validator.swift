//
//  Validator.swift
//  Hemma
//
//  Created by Ahmed Madeh.
//

import Foundation

class Validator {
    static func validate(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func validate(mobile: String) -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", "^(009665|05|5|\\+9665)(5|0|3|6|4|9|1|8|7)([0-9]{7})")
        return regex.evaluate(with: mobile)
    }
    
    static func validate(idNumber: String) -> Bool {
        let idString = idNumber
        // check for count
        if (idString.count != 10) { return false }
        // check for first number
        guard let type = Int(String(idString.first!)) else { return false}
        if type != 2 && type != 1 { return false }
        // check for idNumber is valid numeric number
        if Int(idString) == nil { return false }
        // get sum
        let sum = idString.enumerated().reduce(0) { (sum, item) -> Int in
            let i = item.offset
            var sumTemp = sum
            if (i % 2 == 0) {
                let ZFOdd = String(format: "%02d", Int(String(idString.charAt(at: i)))! * 2)
                sumTemp += Int(String(ZFOdd.charAt(at: 0)))! + Int(String(ZFOdd.charAt(at: 1)))!
            } else {
                sumTemp += Int(String(idString.charAt(at: i)))!
            }
            return sumTemp
        }
        // check for sum
        if (sum % 10 != 0) {
            return false
        }else if (type == 1) {
            return true
        }else if (type == 2) {
            return true
        }
        return false
    }
    
}
