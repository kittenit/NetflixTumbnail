//
//  Drama.swift
//  NetflixTumbnail
//
//  Created by JIHYUN on 6/12/25.
//

import Foundation

struct DramaCollection  : Decodable{ // 소문자로 변경 후
    var bigbanner : String
    var dramas : [Drama]
    
    
    enum CodingKeys : String, CodingKey { // json 프로퍼티 변경 방법
        case bigbanner = "BIG_BANNER" // 원래 프로퍼티 소문자로 받기
        case dramas = "DRAMAS"
    }
}

struct Drama : Decodable { // json 프로퍼티 변경 방법
    var categorytitle : String
    var posters:[String]
    
    // swift에서 json으로 보낸다 Encodable <-> json에서 swift으로 보낸다 Decodable
    // 이걸 전부 합친게 Codable
    
    enum CodingKeys : String, CodingKey {
        case categorytitle = "CATEGORY_TITLE"
        case posters = "POSTERS"
    }
}
