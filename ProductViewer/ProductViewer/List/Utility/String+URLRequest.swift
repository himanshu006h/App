//
//  String+URLRequest.swift
//  ProductViewer
//
//  Created by Himanshu Saraswat on 26/03/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
// MARK: Service method type
enum MethodType {
    case get
    case post
    case put
    case delete
    
    func get() -> String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"

        }
    }
}
// Mark:- Constants
struct Constants {
    static let kRequestType = "Content-Type"
    static let kContentType = "application/json"
}

extension String {
    func urlRequest(method: MethodType = .get) -> URLRequest {
        let url : URL = {
            let url = URL(string: self)!
            return url
        }()
        
        // Create request
        var request = URLRequest(url: url)
        request.addValue(Constants.kContentType, forHTTPHeaderField: Constants.kRequestType)
        request.httpMethod = method.get()
        return request
    }
}
