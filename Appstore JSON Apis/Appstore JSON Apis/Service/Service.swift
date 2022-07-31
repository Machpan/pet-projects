//
//  Service.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 21.07.2022.
//

import Foundation

class Service{
    
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()){
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()){
        let urlString = "https://rss.applemarketingtools.com/api/v2/ru/apps/top-paid/50/apps.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()){
        let urlString = "https://rss.applemarketingtools.com/api/v2/ru/apps/top-free/50/apps.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void){
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void){
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do{
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, nil)
            } catch{
                completion(nil, error)
            }
        }.resume()
    }
}
