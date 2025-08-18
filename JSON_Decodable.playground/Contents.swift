import UIKit




//Task{
//    
//    let url = URL(string: "https://gvec03gvkf.execute-api.ap-northeast-2.amazonaws.com/")!
//   
//    let (data, _) = try! await URLSession.shared.data(from: url)
//    
//    let jsonString = String(data: data, encoding: .utf8)
//    
//    print(jsonString)
// 그냥 문자열로 만든
//
//}

// <--웬만하면 구조체는 항상 먼저 선언. -->!

//struct DramaCollection  : Decodable{ // 제이슨을 분석하는 용도 Decodable
//    var BIG_BANNER : String
//    var DRAMAS : [Drama]
//}

struct DramaCollection  : Decodable{ // 소문자로 변경 후
    var bigbanner : String
    var dramas : [Drama]
    
    
    enum CodingKeys : String, CodingKey { // json 프로퍼티 변경 방법
        case bigbanner = "BIG_BANNER" // 원래 프로퍼티 소문자로 받기
        case dramas = "DRAMAS"
    }
}

//struct Drama : Decodable { // 이중 구조 ( 속 구조 )
//    var CATEGORY_TITLE : String
//    var POSTERS:[String] // 여러개의 포스터 string 구조로 되어있음
//
//}

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

Task{
    
    let url = URL(string: "https://gvec03gvkf.execute-api.ap-northeast-2.amazonaws.com/")!
    
    let (data, _) = try! await URLSession.shared.data(from: url)
    
    // 타입에 대입해서 만들어줌
    
    let decoder = JSONDecoder()
    let dramaCollection  = try!
    decoder.decode(DramaCollection.self, from: data)
    
    // 에러가 생길 수 있으니 try!
    
    // 해석한 것을 담을 let dramaCollection
    
    //    print("big banner : " , dramaCollection.bigbanner)
    
    // for 문
    for drama in dramaCollection.dramas { // 드라마가 넘어옴
    print("카테고리 타이틀 : ", drama.categorytitle)
    }
    
    // 이중 for문
    for drama in dramaCollection.dramas{ // 드라마 타이틀
        for poster in drama.posters{ // 드라마 포스터
            print("포스트 이미지 주소 : ", poster)
        }
    }
    
    // 전체 출력 ( 각 구조체에 따라 출력 )
    for drama in dramaCollection.dramas {
        print("카테고리 타이틀 : : ", drama.categorytitle)
        for poster in drama.posters {
            print("포스트 이미지 주소 : ", poster )
        }
    }
    
} // task 마무리
    


