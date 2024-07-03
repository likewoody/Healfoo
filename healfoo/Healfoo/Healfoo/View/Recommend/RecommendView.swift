//
//  ContentView.swift
//  Healfoo
//
//  Created by Woody on 7/2/24.
//

/*
    Author : Woody
    Date : 2024.07.02
    Description : 증상에 따른 음식 추천을 받기 위한 input 화면
    Version : 1.0.0
 
 */

import SwiftUI

struct RecommendView: View {
    @State var symptom = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader(content: { geometry in
                ZStack(content: {
                    Text("식단을 더 건강하게 헬푸!")
                        .font(.system(size: 34))
                        .foregroundStyle(.accent)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 10)
                    
                    Text("당신의 증상을 입력하세요")
                        .font(.title3)
                        .padding()
//                        .position(x: geometry.size.width / 2, y: 30)
                        
        //                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 120/255, green: 255/255, blue: 15/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                        .background(.accent)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 15))
                        .padding()
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2.7)
                    
                    
                    TextField("간략한 증상 입력", text: $symptom)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 260)
                    
                    if !symptom.isEmpty{
                        NavigationLink(destination: Show(symptom: $symptom)) {
                            Text("필요한 음식 확인하기")
                                .foregroundStyle(.accent)
                                .padding()
                        }  // NavigationLink
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 1.7)
                        
                    } // if
                    Spacer()
                    
                    .padding()
                    .padding(.bottom, 100)
                }) // ZStack

            }) // GeometryReader
                        

        } // NavigationStack
        .preferredColorScheme(.light)
        
    } // body
} // RecommendView

#Preview {
    RecommendView()
}
