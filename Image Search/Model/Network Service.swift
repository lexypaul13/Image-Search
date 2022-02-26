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
        let endPoints = baseURL + "/search/time/all/?q=\(searchName)"
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

}
