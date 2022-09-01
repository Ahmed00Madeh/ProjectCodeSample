//
//  Messages.swift
//
//  Created by Ahmed Madeh.
//


struct Messages {
    static let agreeWithApproval = "You must agree with approval"
    static let verificationCodeMisMatch = "Verification code does not match"
    static let passwordMisMatch = "Password and Confirm Password don't match"
    static let inValidMobileNumber = "Mobile number should be 10 numbers and starts with 05"
    static let inValidEmail = "Invalid email address"
}

extension Messages {
    static func required(_ field: String) -> String {
        return field.localized + " " + "is required".localized
    }
    
    static func inValid(_ field: String) -> String {
        return "Please enter a valid " + field.localized
    }
}
