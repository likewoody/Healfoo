//
//  FoodView.swift
//  Healfoo
//
//  Created by Woody on 7/3/24.
//

import SwiftUI

struct FoodView: View{
    
    let recommend: Recommend
    
    var body: some View {
        Text("음식")
            .frame(maxWidth: .infinity / 2)
            .font(.title3)
            .foregroundStyle(.white)
            .bold()
            .background(.accent)
            .padding(.top, 20)
        
//                List{
        ForEach(recommend.foodList, id: \.food) { food in
            HStack(content: {
                
                VStack(content: {
                    Text(food.food)
                        .bold()
                    
                }) // VStack
                .frame(width: 80, height: 80)
                
                Divider() // 줄긋기
                
                VStack(alignment: .leading, content: {
                    HStack(content: {
                        Text("포함 비타민 : ")
                            .bold()
                        Text(food.vitamins)
                    }) // Vitamin
                    .padding(.leading, 3)
                    
                    Divider() // 줄긋기
                    
                    HStack(content: {
                        Text("음식 설명 : ")
                            .bold()
                        Text(food.description)
                    }) // Description
                    .padding()
                }) // VStack
//                .padding(.leading, 15)
                
            }) // Hstack
            .padding()
            .background(.accent.opacity(0.1))
            .clipShape(.rect(cornerRadius: 12))
            .shadow(radius: 15)
            
        } // ForEach
        .padding()
//                .padding(.vertical, 5) // 각 아이템 사이의 수직 간격
//                } // List
//                .listStyle(.plain)
    } // body
} // FoodView

//#Preview {
//    FoodView()
//}
