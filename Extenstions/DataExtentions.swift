//
//  DataExtentions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension Data {
    func mimeType() -> String {
        var b: UInt8 = 0
        copyBytes(to: &b, count: 1)
        switch b {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
    
    func fileType() -> FileType {
        switch mimeType() {
        case "image/jpeg":
            return .image(extention: "jpeg")
        case "image/png":
            return .image(extention: "png")
        case "image/gif":
            return .image(extention: "gif")
        case "image/tiff":
            return .image(extention: "tiff")
        case "application/pdf":
            return .document(extention: "pdf")
        case "application/vnd":
            return .document(extention: "vnd")
        case "text/plain":
            return .document(extention: "doc")
        default:
            return .unKnown
        }
    }
    
    func saveAsTemp(withName name: String, fileExtention: String) -> URL? {
        saveAsTemp(withName: "\(name).\(fileExtention)")
    }
    func saveAsTemp(namedWithAutoExtention named: String) -> URL? {
        var fileExtention = ""
        switch fileType() {
        case .image(extention: let extention):
            fileExtention = extention
            
        case .document(extention: let extention):
            fileExtention = extention
            
        default:
            debugPrint("unKnown file type")
            return nil
        }
        return saveAsTemp(withName: "\(named).\(fileExtention)")
    }
  
    func saveAsTemp(withName name: String) -> URL? {
        let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
        let targetURL = tempDirectoryURL.appendingPathComponent(name)
        do {
            try write(to: targetURL)
            return targetURL
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}

enum FileType {
    case image(extention: String)
    case document(extention: String)
    case unKnown
}
