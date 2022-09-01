//
//  String.swift
//
//  Created by Ahmed Madeh.
//

import Foundation
import UIKit

extension String {

    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        let range = start..<end
        return String(self[range])
    }
}
extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isPhoneNumber: Bool {
        if count != 11 { return false }
        if String(self.prefix(2)) != "01" { return false }
        return true
    }
    
    var isValidPassword: Bool {
        return count > 8
    }

    public var initials: String {
        var finalString = String()
        var words = components(separatedBy: .whitespacesAndNewlines)
        
        if let firstCharacter = words.first?.first {
            finalString.append(String(firstCharacter))
            words.removeFirst()
        }
        return finalString.uppercased()
    }

    var intValue : Int {
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        var result = self
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }

        result = result.replacingOccurrences(of: " \("SAR".localized)", with:"" )
        return Int(result) ?? 0
    }
  
    var englishPhoneNumber : String {
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        var result = self
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        return result
    }
    
    var doubleValue: Double { Double(self) ?? 0.0 }
    
    var floatValue: Float { Float(self) ?? 0.0 }
    
    var htmlToAttributedString: NSAttributedString? {
          guard let data = data(using: .utf8) else { return NSAttributedString() }
          do {
              return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
          } catch {
              return NSAttributedString()
          }
      }
    
      var htmlToString: String { htmlToAttributedString?.string ?? "" }
}

extension String {
    func size(usingFont font: UIFont) -> CGSize {
        let label = UILabel.init()
        label.text = self
        label.font = font
        return label.bounds.size
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return size(withAttributes: fontAttributes)
    }
}

extension String {
    func charAt(at: Int) -> Character {
        let charIndex = index(startIndex, offsetBy: at)
        return self[charIndex]
    }
}

extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        Data(self.utf8).base64EncodedString()
    }
    
    func absoluteBase64() -> String {
        if let string = components(separatedBy: "base64,").last,
           components(separatedBy: "base64,").count == 2 {
            return string
        }
        return self
    }
}
