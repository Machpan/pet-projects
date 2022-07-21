//
//  Service.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 21.07.2022.
//

import Foundation

class Service{
    
    static let shared = Service()
    func fetchApps(completion: @escaping ([Result], Error?) -> ()){
        print("Fetching itunes apps from Service layer")
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                completion([], nil)
                return
            }
            guard let data = data else { return }
            do{
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
            } catch let jsonErr{
                print("Failed to decode json:", jsonErr)
                completion([], jsonErr)
            }
        }.resume()
    }
}
