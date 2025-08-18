//
//  HomeView.swift
//  NetflixTumbnail
//
//  Created by JIHYUN on 6/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var bigbanner : String = ""
    @State var dramas : [Drama] = [] // 빈 배열
    
    var body: some View {
        
        ScrollView{
            HStack{
                
                Image("logo")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                
                Spacer() // 둘의 위치 조정 (멀어짐 )
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                
                
            }// 로고 부분
            
            //            AsyncImage(url: URL(string: "https://ios-poster-json.s3.ap-northeast-2.amazonaws.com/posters/0BigImagePoster/bigPoster.png"))
            // 외부 사진 불러오기 (json)
            
            // 왜 인터넷에서 사진을 불러올까?
            // appstore에서 심사 받을 때 오래 걸림 -> app에 변화가 생김 - >
            // 포스터에 변화가 생기면 매번하기에는 번거로움
            // 그래서 웹 사이트(서버)에서 사진을 받아옴
            // assets은 로컬
            
            // 링크 바로 불러 온 버전          AsyncImage(url:   URL(string: "https://ios-poster-json.s3.ap-northeast-2.amazonaws.com/posters/0BigImagePoster/bigPoster.png"))
            
            AsyncImage(url:   URL(string: bigbanner)) { image in // 이 페이지에서 받은 이미지를 어떻게 처리?
                
                image
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit) // 비율에 맞게끔 커짐
                    .frame(width: 300, height: 500) // 사진 사이즈
                
            } placeholder: { // 이미지가 제대로 수신이 안되면 어떻게 함?
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .frame(width: 300, height: 500)
                    .opacity(0.5)
                    .overlay(ProgressView() // 버퍼링 표시 보여줌
                        .tint(Color.gray))
            }
            
            .overlay(alignment: .bottom) { //화면 위에 화면을 쌓는 view
                HStack{
                    Button(action: {
                        print("再生してください")
                    }, label: {
                        Image(systemName: "play.fill")
                    })
                    .buttonStyle(.bordered)  // 아이콘 테두리 추가
                    
                    Button(action: {
                        print("情報ボタンを押した")
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                    .buttonStyle(.bordered)  // 아이콘 테두리 추가
                }
                .padding() // 살짝 위에 뜸 위치가
            }
            
            
            // 포스트 하단
            
            if dramas.count == 0 { // 배열의 갯수가 0개 일때만 보여주라 ( 통신이 완료 되기 전 버퍼링 )
                ProgressView() // 버퍼링 표시 해주는 view ( 전체가 통신 안됐을 때 버퍼링 )
                    .tint(Color.white)
                    .padding()
                
                    .task {
                        let url = URL(string: "https://gvec03gvkf.execute-api.ap-northeast-2.amazonaws.com/")!
                        
                        do {
                            let (data, _) = try await URLSession.shared.data(from: url)
                            let decoder = JSONDecoder()
                            let dramaCollection = try decoder.decode(DramaCollection.self, from: data)
                            
                            bigbanner = dramaCollection.bigbanner
                            dramas = dramaCollection.dramas
                            
                        } catch {
                            print("🔥 Error loading data: \(error)")
                            // 여기에 사용자에게 보여줄 오류 메시지를 설정할 수도 있음
                        }
                    } // try! 는 오류가 발생할 수 없는 경우에 사용 ( 허나, 위험이 발생하기 때문에 잘 사용 안함 )
                
//                    .task { // ProgressView 가 뜨면 task 코드가 떠라
//                        // 뜬 후 바로 내부 코드가 실행
//                        let url = URL(string: "https://gvec03gvkf.execute-api.ap-northeast-2.amazonaws.com/")!
//                        
//                        let (data, _) = try! await URLSession.shared.data(from: url)
//                        
//                        let decoder = JSONDecoder()
//                        let dramaCollection  = try!
//                        decoder.decode(DramaCollection.self, from: data)
//                        
//                        bigbanner = dramaCollection.bigbanner // 빈 string에 dramaCollection.bigbanner 추가
//                        dramas = dramaCollection.dramas //  빈 [] 배열에 추가
//                    }
            } else { // 배열이 채워지면
                
                ForEach(dramas, id: \.categorytitle) {drama in // Identifiable를 지정 안해줬으면 반드시 아이디 직접 지정
               // dramas라는는 배열에서 돌건데 각각의 원소는 drama에서 갖다 쓸게
                   
                    VStack(alignment: .leading){ // 왼쪽 정렬
                        Text(drama.categorytitle)
                            .font(.title)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing:20){ // 각 hstack 공간 넓이 추가
                                
                                ForEach(drama.posters , id:\.self){
                                    PosterUrlString in  // 각각의 이미지 주소들이 PosterUrlString 에 들어옴
                                    let url = URL(string: PosterUrlString)
                                    
                                    AsyncImage(url: url){ image in
                                        image
                                            .resizable() // 사이즈 조절
                                        
                                    } placeholder : {
                                        ProgressView() // 이미지 하나하나 버퍼링
                                    }
                                    .frame(width:100, height:180) //사진이 바뀔 시 사이즈 고정
                                    .cornerRadius(10) // 모서리 둥글 ~
                                }
                                
                            }
                            .padding(.horizontal) // 가로 공간
                            
                        }
                    }
                    
                }
                
            }// else 종료
        }
               
        .background(.black) // 백 컬러
        .foregroundStyle(.white) // 아이콘 컬러 하얀색으로 보이게
            
        }
    }
    
    #Preview {
        HomeView()
    }

