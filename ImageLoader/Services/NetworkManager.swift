//
//  NetworkManager.swift
//  ImageLoader
//
//  Created by Dmitry Kononchuk on 27.02.2022.
//

import Foundation

enum NetworkError: String, Error {
    case badURL = "Bad URL or nil"
    case noData = "Unable to get data"
}

class NetworkManager {
    // MARK: - Public Properties
    static let shared = NetworkManager()
    
    // MARK: - Private Initializers
    private init() {}
    
    // MARK: - Public Methods
    func fetchImageData(from url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return completion(.failure(.badURL))}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return completion(.failure(.noData)) }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}
