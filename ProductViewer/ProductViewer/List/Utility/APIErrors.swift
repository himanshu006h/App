//
//  APIErrors.swift
//  ProductViewer
//
//  Created by Himanshu Saraswat on 26/03/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

enum APIErrors : Error {
    // More generalized versions of these cases can be formed for extensive error handling
    case requestFailed(error: NSError)
    case responseUnsuccessful
    case invalidData
    case invalidURL
    case jsonParsingFailure
}

