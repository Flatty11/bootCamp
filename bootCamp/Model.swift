//
//  Model.swift
//  bootCamp
//
//  Created by Илья on 7/15/22.
//

import Foundation

final class Model {
    
    private let networkManager = NetworkManager.shared
    var services = [InnerItem]()

    func getData(completion: @escaping () -> Void) {
        NetworkManager.shared.getServices{ [weak self] result in
            switch result {
            case .success(let respone):
                DispatchQueue.main.async {
                    self?.services = respone.body.services
                    completion()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
