//
//  SocialApp.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 30.07.2022.
//

import Foundation

struct SocialApp: Decodable, Hashable{
    
    let id, name, imageUrl, tagline: String
}
