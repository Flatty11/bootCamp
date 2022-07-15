//
//  NetworkManager.swift
//  bootCamp
//
//  Created by Илья on 7/15/22.
//

import Foundation

protocol NetworkManagerDescription {
    func getServices(completion: @escaping (Result<Root, Error>) -> Void)
}

enum NetworkError: Error {
    case invalidUrl
    case emptyData
}

final class NetworkManager: NetworkManagerDescription {
    
    static let shared: NetworkManagerDescription = NetworkManager()
    
    private init() {}
    
    func getServices(completion: @escaping (Result<Root, Error>) -> Void) {
        guard let url = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json") else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let services = try decoder.decode(Root.self, from: data)
                completion(.success(services))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
