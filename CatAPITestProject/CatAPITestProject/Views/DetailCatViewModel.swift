//
//  DetailCatViewModel.swift
//  CatAPITestProject
//
//  Created by Евгений on 25.11.21.
//

import Foundation

class DetailCatViewModel {
    
    var images: [Image] = []
    var breed: Breed?
    
    func getImage(completion: @escaping () -> Void) {
        guard let breedId = breed?.id else { return }
        NetworkManager.shared.getImageForBreed(breedId: breedId) { [weak self] result in
            switch result {
            case .success(let images):
                self?.images = images
                completion()
            case .failure:
                print("FAILED")
            }
        }
    }
    
}
