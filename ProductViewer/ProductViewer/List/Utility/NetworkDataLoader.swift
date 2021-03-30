//
//  NetworkDataLoader.swift
//  ProductViewer
//
//  Created by Himanshu Saraswat on 26/03/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

typealias QueryCompletionHandler = (_ result : Swift.Result<ListModel, APIErrors>) -> Void
typealias FetchResult = Result<Any, APIErrors>

enum ServiceType: Int {
    case deals = 0
}

struct NetworkDataLoaderConstant {
    static let baseUrlString = "https://api.target.com/mobile_case_study_deals/v1/deals"
}

class NetworkDataLoader {
    var dataTask: URLSessionDataTask?
    let decoder = JSONDecoder()
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func loadResult(urlString: String = NetworkDataLoaderConstant.baseUrlString, serviceType: ServiceType = ServiceType.deals
        , bodyPram: [String: Any] = [String: Any](), completion: @escaping QueryCompletionHandler) {
        
        var request: URLRequest
        switch serviceType {
        case .deals:
            request = urlString.urlRequest()
        }
        
        dataTask = session.dataTask(with: request) { data, response, error in
            defer { self.dataTask = nil }
            if error != nil {
                completion(.failure(.responseUnsuccessful))
                return
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 || response.statusCode == 201 {
                self.parseData(data, serviceType: serviceType, completion: { result in
                                        switch result {
                                        case let .success(feedInfo): completion(.success(feedInfo))
                                        case let .failure(error) : completion(.failure(error))
                                        }
                })
            }else{
                if (response as? HTTPURLResponse) != nil{
                    completion(.failure(.responseUnsuccessful))
                }
            }
        }
        dataTask?.resume()
    }
    
    //Parse Data as per service type
    private func parseData(_ data: Data, serviceType: ServiceType = ServiceType.deals, completion: QueryCompletionHandler) {
        switch serviceType {
        case .deals:
            do {
                let productInfo = try decoder.decode(ListModel.self, from: data)
                completion(.success(productInfo))
            } catch _ as NSError {
                completion(.failure(.jsonParsingFailure))
                return
            }
        }
    }
}

