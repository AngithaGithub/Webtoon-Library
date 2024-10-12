//
//  ApiManager.swift
//  Webtoon Library App
//
//  Created by oem on 11/10/24.
//

import Foundation
class ApiManager {
    static let shared = ApiManager()
    
    func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }.resume()
    }
    
    enum ApiError: Error {
        case noData
        case invalidUrl
    }
}
