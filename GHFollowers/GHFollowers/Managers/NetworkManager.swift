//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Apple on 9/9/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cashe = NSCache<NSString,UIImage>()
    
    private init() {}
    
    func getFollowers(for userName: String,
                    page: Int,
                    completed: @escaping (Result<[Follower], GFError>) -> Void){
        
        let endPoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else{
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let follower = try decoder.decode([Follower].self, from: data)
                completed(.success(follower))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getUserInfo(for userName: String,
                    completed: @escaping (Result<User, GFError>) -> Void){
        
        let endPoint = baseUrl + "\(userName)"
        
        guard let url = URL(string: endPoint) else{
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let casheKey = NSString(string: urlString)
        
        if let image = cashe.object(forKey: casheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                 error == nil,
                 let response = response as? HTTPURLResponse, response.statusCode == 200,
                 let data = data,
                 let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            self.cashe.setObject(image, forKey: casheKey)
            completed(image)
        }
        task.resume()
    }
}
