//
//  Show.swift
//  Healfoo
//
//  Created by Woody on 7/2/24.
//
    
/*
    Author : Woody
    Date : 2024.07.02
    Description : 증상에 따른 음식 추천을 Show 화면
 
    2.
    Date : 2024.07.08
    Description : show 할 때 SQLite Insert 연결 작업 
 */

import SwiftUI

struct Show: View {
    
    @Binding var symptom: String
    @State var recommend: Recommend = Recommend(foodList: [], materials: [], needVitamins: [])
    @StateObject var dateState = MyState()
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            
            // MARK: 전체 ScrollView
            ScrollView {
                // MARK: Title Section
                VStack(content: {
                    Text(" \"\(symptom)\"")
                        .font(.system(size: 34))
                        .bold()
                        .foregroundStyle(.accent)
                    Text("에 필요한 식재료와 음식!")
                        .font(.title2)
                }) // VStack
                .padding(.top, 30)
                
                Divider()
                
                // MARK: 필요 비타민 Section
                NeedVitamins(recommend: recommend)
                
                Divider()
                
                // MARK: 식재료 Section
                MaterialView(recommend: recommend)
                
                Divider()
                
                // MARK: 음식 Section
                FoodView(recommend: recommend)
                
            } // 전체 ScrollView
            
        }  // NavigationStack
        .preferredColorScheme(.light)
        .onAppear(perform: {
            let query = MySQLVM()
            let sqlite = SQLiteVM()
            
            Task{
                recommend = await query.urlRecommend(userInput: symptom)
                
                // needVitamins "," 기준으로 나눠서 String으로 변환
                let vitamins = recommend.needVitamins.joined(separator: ",")
                _ = sqlite.insertDB(symptom: symptom, vitamins: vitamins, date: dateState.dateFormatter.string(from: Date()))
            } // Task
        }) // onAppear
        .onDisappear(perform: {
            // 초기화 시키기
            symptom = ""
        }) // onDisappear
        
    } // body
} // ShowView

//#Preview {
//    Show(recommendModel: )
//}
