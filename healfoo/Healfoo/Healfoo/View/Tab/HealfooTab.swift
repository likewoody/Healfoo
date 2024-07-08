//
//  Tab.swift
//  Healfoo
//
//  Created by Woody on 7/3/24.
//

import SwiftUI

struct HealfooTab: View {
    @State var selection: Int = 0
    var body: some View {
        TabView(selection: .constant(0),
                content:  {
            RecommendView().tabItem {
                Image(systemName: "star.fill")
                Text("음식 추천")
                    .padding()
            }.tag(0)
            History().tabItem {
                Image(systemName: "clock")
                Text("히스토리")
            }.tag(1)
        }) // TabView
    } // body
} // HealfooTab

#Preview {
    HealfooTab()
}
