//
//  NetworkManager.swift
//  CatAPITestProject
//
//  Created by Евгений on 25.11.21.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case domainError
    case decodingError
    case authError
}

class NetworkManager {
    
    private init () {}
    
    static let shared = NetworkManager()
    
    private let serverUrl = "https://api.thecatapi.com/v1/"
    private let xApiKey = "8899ac11-4038-45c5-828d-18d936bc7df3"
    
    func createUrlWithoutParams(method: String) -> URL? {
        let urlString = serverUrl + method + "?api_key=\(xApiKey)"
        return URL(string: urlString)
    }
    
    func createUrlWithParams(method: String, params: [String : Any]) -> URL? {

        var paramsDict: [String : Any] = ["api_key": xApiKey]

        params.forEach { (key, value) in
            paramsDict[key] = value
        }
        
        let paramsStr: String = paramsDict.map { "\($0)=\($1)" }.joined(separator: "&")
        
        let urlString = serverUrl + method + "?" + paramsStr
        return URL(string: urlString)
    }
    
    func performRequest(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(nil, error)
                }
                return
            }
            do {
                completion(data, nil)
            } catch let e {
                completion(nil, e)
            }
            
        }
        task.resume()
    }
    
    func getBreed(completion: @escaping (Result<[Breed],NetworkError>) -> Void) {

        //guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?api_key=8899ac11-4038-45c5-828d-18d936bc7df3") else { return }
        guard let url = createUrlWithoutParams(method: "breeds") else { return }
        
        var breed: [Breed] = []
        performRequest(url: url) { data, error in

            do {
                breed = try JSONDecoder().decode([Breed].self, from: data!)
                completion(.success(breed))
            } catch {
                completion(.failure(.decodingError))
            }
        }
    }
    
    func getImageForBreed(breedId: String, completion: @escaping (Result<[Image],NetworkError>) -> Void) {
        
        guard let url = createUrlWithParams(method: "images/search", params: ["limit" : 5, "breed_id" : breedId]) else { return }
        
        var image: [Image] = []
        performRequest(url: url) { data, error in
            
            do {
                image = try JSONDecoder().decode([Image].self, from: data!)
                completion(.success(image))
            } catch {
                completion(.failure(.decodingError))
            }
        }
    }
    
}
