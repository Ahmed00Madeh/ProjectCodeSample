//
//  NetworkManager.swift
//
//  Created by Ahmed Madeh.
//

import ESNetworkManager
import Alamofire

final class NetworkManager: ESNetworkManager {
    
    /// Used to bypass the SSL pining
    static let session: Session = {
        let manager = ServerTrustManager(evaluators: ["awfarlak.net": DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    override class var Manager: Session { session }
    
    override class func map(_ response: AFDataResponse<Any>) -> ESNetworkResponse<JSON> {
        if response.response?.statusCode == 401 {
            UserModel.current = nil
            UIApplication.initWindow()
            return .failure(NSError.init(error: "_session_expired", code: 401))
        }
        
        if let error = response.error {
            return .failure(error)
        }
        
        debugPrint(response.value ?? "No response")
        let json = JSON(response.value)
        let status: Int = json.status.value() ?? 1
        let errors: [[String: String]] = json.errors.value() ?? []
        
        if let _ = response.value as? [[String: Any]] {
            return .success(json)
        }
        
        switch status {
        case 200, 105:
            return .success(json)
        case 401:
            return .failure(NSError.init(error: "_session_expired", code: 401))
            
        case let code where !errors.isEmpty:
            return .failure(NSError.init(error: errors.first?["value"] ?? "Something went wrong", code: code))
        case let code:
            return .failure(NSError.init(error: "Error \(code)", code: code))
        }
    }
}

extension ESNetworkRequest {
    convenience init(_ path: String) {
        self.init(base: Constants.baseUrl, path: path)
        self.headers = ["Accept": "application/json",
                        "Accept-language": Language.currentLanguage.rawValue]
        self.selections = [.key("data")]
        if let user = UserModel.current {
            self.headers?["Api-Token"] = user.token
        }
        debugPrint(self)
    }
}
