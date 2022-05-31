//
//  NetworkManager.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/12/22.
//

import Foundation
import UIKit

// class
final class NetworkManager<T: Codable> {
    
    // function that fetches from the URL
    func fetch(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.error(err:error!.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse(response: response!.description)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
                
            } catch let err {
                completion(.failure(.decodingError(err: err.localizedDescription)))
                print(err)
            }
            
        } .resume()
    }
}

// enumeration called error with different cases
enum NetworkError: Error {
    
    // different errors that can occur with the network
    case error(err: String)
    case invalidResponse(response: String)
    case invalidData
    case decodingError(err: String)
}
