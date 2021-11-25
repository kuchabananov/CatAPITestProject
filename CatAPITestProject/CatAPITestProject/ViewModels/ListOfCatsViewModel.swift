//
//  ListOfCatsViewModel.swift
//  CatAPITestProject
//
//  Created by Евгений on 25.11.21.
//

import Foundation


class ListOfCatsViewModel {
        
    var breeds: [Breed] = []
    
    func getBreeds(completion: @escaping () -> Void) {
        NetworkManager.shared.getBreed { [weak self] result in
            switch result {
            case .success(let breeds):
                self?.breeds = breeds
                completion()
            case .failure:
                print("FAILED")
            }
        }
    }
    
    
}
