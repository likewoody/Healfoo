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
    Version : 1.0.0
 */

import SwiftUI

struct Show: View {
    
    @Binding var symptom: String
    @State var recommend: Recommend = Recommend(foodList: [], materials: [], needVitamins: [])
    
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
                
                
                // MARK: 필요 비타민 Section
                NeedVitamins(recommend: recommend)
                
                // MARK: 식재료 Section
                MaterialView(recommend: recommend)
                
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
                _ = sqlite.insertDB(symptom: symptom, vitamins: recommend.needVitamins)
            } // Task
        }) // onAppear
        .onDisappear(perform: {
            // 초기화 시키기
            symptom = ""
        }) // onDisappear
        //        .toolbar(content: {
        //            ToolbarItem(placement: .principal) {
        //                Text("추천 음식")
        //                    .foregroundStyle(.accent)
        //            } // ToolbarItem
        //        }) // toolbar
        //        .navigationBarTitleDisplayMode(.inline)
        
    } // body
} // ShowView

//#Preview {
//    Show(recommendModel: )
//}
