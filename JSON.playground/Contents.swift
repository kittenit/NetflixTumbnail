import UIKit

Task{
    
    
    let url = URL(string: "https://gvec03gvkf.execute-api.ap-northeast-2.amazonaws.com/")!
    // ! 하는 이유는 data(from: url) 가 optional 이 아님 그러나 let url 은 optional인데
    // optional type은 data(from: url) 여기에서 못받아서  !를 붙여서 optional를 벗김
    
    let (data, _) = try! await URLSession.shared.data(from: url)
    // URLSession 은 swift에서 사이트에 접속하기 위해서 반드시 필요함 ( 접근에 필요 ) URLSession.shared 같이 씀
    // URLSession.shared.data(빼올 데이터), (from.url)은 어디에서 갖고 오는 거니
    
    //  (data, _) 는 data랑 _ 안받는 거를 표기한 
    //await 은 항상 task안에 있어야 함 , 또한 await는 url를 가져오는데 시간 좀 걸린다는
    
    
    let jsonString = String(data: data, encoding: .utf8)
    
    print(jsonString)
   
    
}
// json을 인식하기 위한 방법 ( swift ui가 인식 할 수 있게 )


