//
//  Query.swift
//  Healfoo
//
//  Created by Woody on 7/2/24.
//

import Foundation

struct MySQLVM{
    func urlRecommend(userInput: String) async -> Recommend {
        // 동적 IP이기 때문에 EC2를 껐다 켤 때마다 IP가 변할 수 있음
        let serverAddress = "43.200.6.191:8000"
        let url = "http://\(serverAddress)/recommendByUserInput?userInput=\(userInput)"
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            let recommendation = try JSONDecoder().decode(Recommend.self, from: data)
            
            return recommendation
            
        } catch {
            print("1. JSON 디코딩 오류:", error)
            // 오류를 적절하게 처리합니다 (예: 사용자에게 오류 메시지 표시)
            return Recommend(foodList: [], materials: [], needVitamins: [])
        } // catch

    } // Recommend
}
