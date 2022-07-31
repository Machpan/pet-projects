//
//  AppGroup.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 30.07.2022.
//

import Foundation

struct AppGroup: Decodable{
    
    let feed: Feed
}

struct Feed: Decodable{
    
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable{
    
    let id, name, artistName, artworkUrl100: String
}
