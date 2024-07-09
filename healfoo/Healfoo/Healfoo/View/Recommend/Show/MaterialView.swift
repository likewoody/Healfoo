//
//  MaterialView.swift
//  Healfoo
//
//  Created by Woody on 7/3/24.
//

import SwiftUI

struct MaterialView: View{
    
    let recommend: Recommend
    
    var body: some View {
        Text("식재료")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 18))
//            .foregroundStyle(.white)
//            .bold()
//            .background(.accent)
            .padding([.top, .leading], 20)
            
        
        ScrollView(.horizontal) {
            Spacer()
            
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 100))], spacing: 10, content: {
            
                HStack(content: {
                    ForEach(recommend.materials, id: \.self) { material in
                        VStack(content: {
//                            Circle()
                            Image(material)
                                .resizable()
                                .frame(width: 100, height: 100)
//                                .foregroundStyle(.accent)
                                .clipShape(.rect(cornerRadius: 45))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 45)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                ) // stroke 만들기
                                .padding()
                                
                            
                            Text(material)
                        }) // VStack
                    } // ForEach
                }) // HStack
            }) // LazyHGrid
                Spacer()
        } // ScrollView
        .frame(height: 200)
    } // body
} // MaterialView

//#Preview {
//    MaterialView()
//}
