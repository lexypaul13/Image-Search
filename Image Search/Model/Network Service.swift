//
//  Network Service.swift
//  Image Search
//
//  Created by Alex Paul on 2/25/22.
//

import UIKit

class NetworkService{
    static let shared = NetworkService()
    private let baseURL = "https://api.imgur.com/3/gallery"
    private init() {}
    
    let cache   = NSCache<NSString, UIImage>()

    
    func getJSON( searchName: String, completion: @escaping([PhotoModel]?) -> Void){
        let endPoints = baseURL + "/search/time/week/?q=\(searchName)"
        guard let url = URL(string: endPoints ) else{return}
        var request =  URLRequest(url: url)
        let headers = ["Authorization": "Client-ID 82883e01a127f3c"]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to query database", error)
            }
            guard let data = data else {
                print("Data not received\(String(describing: error))")
                return
            }
            let decoder = JSONDecoder()
            do{
                let decodedJson = try decoder.decode(PhotoResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedJson.data)
                }

            }catch let error{
                print("Json failed to decode\(String(describing: error))")
                return
            }
        }.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) { // downloads image
        let cacheKey = NSString(string: urlString) // creates cacheKey to store in image variable
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        if let image = cache.object(forKey: cacheKey) { // check if image is there
            completed(image)
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
            DispatchQueue.main.async { [weak self] in
                self?.cache.setObject(image, forKey: cacheKey)
                completed(image)
            }
        }
        task.resume()
    }

}
