//
//  KeyChain.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

final class KeyChain {
    
    @discardableResult
    fileprivate static func set(value: String, key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
 
        let query = [
              kSecClass as String: kSecClassGenericPassword as String,
              kSecAttrAccount as String: key,
              kSecValueData as String: data
        ] as [String : Any]

        let status = SecItemAdd(query as CFDictionary, nil)
        if (status != errSecSuccess) {
            if let err = SecCopyErrorMessageString(status, nil) {
                debugPrint("Write failed: \(err)")
            }
        }
        return status == errSecSuccess
    }
    
    fileprivate static func value(forKey key: String) -> String? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String : Any]
        var dataTypeRef :AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let retrievedData = dataTypeRef as? Data else { return nil }
        return String(data: retrievedData, encoding: String.Encoding.utf8)
    }
    
    @discardableResult
    fileprivate static func removeValue(forKey key: String) -> Bool {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ] as [String : Any]
        let status = SecItemDelete(query as CFDictionary)

        if (status != errSecSuccess) {
            if let err = SecCopyErrorMessageString(status, nil) {
                debugPrint("Write failed: \(err)")
            }
        }
        return status == errSecSuccess
    }
    
}

extension KeyChain {
    static func store(account: Account) {
        set(value: account.userId, key: "USERID")
        set(value: account.password, key: "PASSWORD")
    }
    
    static func storeAccount() -> Account? {
        guard let userId = value(forKey: "USERID"),
              let password = value(forKey: "PASSWORD")
        else { return nil }
        return .init(userId: userId, password: password)
    }
    
    static func removeStoredAccount() {
        removeValue(forKey: "USERID")
        removeValue(forKey: "PASSWORD")
    }
}

struct Account {
    let userId: String
    let password: String
}
