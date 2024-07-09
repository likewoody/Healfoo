//
//  NeedVitamins.swift
//  Healfoo
//
//  Created by Woody on 7/3/24.
//

import SwiftUI

struct NeedVitamins: View {
    let recommend: Recommend
    
    var body: some View {
        Text("필요 비타민")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 18))
//            .foregroundStyle(.white)
//            .bold()
//            .background(.accent)
            .padding([.top, .leading], 20)
            
        
        ScrollView(.horizontal) {
            Spacer()
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10, content: {
                // List, Grid는 무조건 ForEach로 반복해서 데이터를 보여진다.
                ForEach(recommend.needVitamins, id: \.self, content: { vitamin in
                    
                    VStack(alignment: .center,content: {
                        Text(vitamin)
                            .frame(width: 60, height: 60)
                            .background(.orange.opacity(0.6))
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.leading, 50)
                    }) // VStack
                                                
                }) // ForEach
                
            }) // LazyVGrid
                
        } // ScrollView
        .padding(.bottom, 20)
    } // body
} // NeedVitamins

//#Preview {
//    NeedVitamins()
//}
