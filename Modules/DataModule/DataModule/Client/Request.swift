//
//  HttpClient.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift

extension RestMethod {
    
    var alamofireMethod: HTTPMethod {
        switch self {
        case .get: return .get
        default: return .post
        }
    }
}

fileprivate let headers: [String: String] = [
    "Content-Type": "application/json",
    "Accepts": "application/json"
]

class Request<T: Codable> {
  
    private(set) var endpoint: Endpoint<T>
    
    private(set) var parameters: [String: Any]?
    
    private(set) var rootUrl: String
    
    init(rootUrl: String, endpoint: Endpoint<T>, parameters: [String: Any]? = nil) {
        self.endpoint = endpoint
        self.parameters = parameters
        self.rootUrl = rootUrl
    }
    
    func send() -> Observable<T?> {
        
        let fullUrl = UrlHelper.getDynamicUrl(rootUrl: rootUrl,
                                              endpoint: endpoint,
                                              parameters: parameters)
        
        
        guard let url = URL(string: fullUrl) else { return Observable.just(nil) }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method == .get ? "GET" : "POST"
        request.allHTTPHeaderFields = headers
        
        debugPrint("request: \(endpoint.method.alamofireMethod) \(request.allowsCellularAccess)")
        
        return Observable.create({ (observer) -> Disposable in
            
            SessionManager.default
                .request(request)
                .responseData { (response) in
                    
                    guard let data = response.data else {
                        observer.onCompleted()
                        return
                    }
                    let decoder = JSONDecoder()
                    do {
                        let value = try decoder.decode(T.self, from: data)
                        observer.onNext(value)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
            }
            
            return Disposables.create()
        })
    }
}
