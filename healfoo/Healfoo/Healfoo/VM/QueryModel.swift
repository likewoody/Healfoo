//
//  Query.swift
//  Healfoo
//
//  Created by Woody on 7/2/24.
//

import Foundation

struct QueryModel{
    func urlRecommend(httpURL: String) async -> Recommend {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: httpURL)!)
            let recommendation = try JSONDecoder().decode(Recommend.self, from: data)
            
            return recommendation
            
        } catch {
            print("1. JSON 디코딩 오류:", error)
            // 오류를 적절하게 처리합니다 (예: 사용자에게 오류 메시지 표시)
            return Recommend(foodList: [], materials: [], needVitamins: [])
        } // catch

    } // Recommend
}
