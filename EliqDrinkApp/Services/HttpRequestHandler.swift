//
//  HttpRequestHandler.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-22.
//

import Foundation
import Network


final class HttpRequestHandler : NSObject {
    
    static let shared = HttpRequestHandler()
    
    func request(endPoint: String, onSuccess: @escaping(Data?) -> Void, onFailure: @escaping(String) -> Void){
        
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, urlResponse, error) in
            if let data = data {
                onSuccess(data)
            } else if let error = error {
                onFailure("HTTP Request Failed \(error.localizedDescription)")
            }
        }).resume()
    }
    
}
