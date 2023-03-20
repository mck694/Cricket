//
//  APIMangaer.swift
//  Cricket
//
//  Created by Manjunath C Kadani on 16/03/23.
//

import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(_ error: Error?)
}

typealias Handler = (Result<Team, DataError>) -> (Void)

//typealias HandlerTTTT = (Result<CricketTeam, DataError>) -> (Void)

// Singleton Design Pattern

final class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func fetchMatchDetails(completion : @escaping Handler) {
        guard let url = URL(string: Constant.API.nzinURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else {
                completion(.failure(.invalidData))
                return
                
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
                
            }
            
            do {
                let matchDetails = try JSONDecoder().decode(Team.self, from: data)
                completion(.success(matchDetails))
            } catch {
                completion(.failure(.network(error)))
            }
            
        }.resume()
    }
}
