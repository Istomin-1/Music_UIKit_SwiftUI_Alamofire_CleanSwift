//
//  NetworkService.swift
//  Music(SwiftUI + Alamofire)
//
//  Created by Mikhail on 03.04.2021.
//

import UIKit
import Alamofire


class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parametrs = ["term":"\(searchText)","limit":"20","media":"music"]
        
        AF.request(url, method: .get, parameters: parametrs, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                completion(objects)
                
            } catch let jsonError {
                print("Error JSON: \(jsonError.localizedDescription)")
                completion(nil)
            }
        }
    }
}
