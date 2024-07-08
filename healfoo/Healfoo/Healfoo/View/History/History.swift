//
//  History.swift
//  Healfoo
//
//  Created by Woody on 7/3/24.
//

/*
    Author : Woody Jo
    Date : 24.07.08
    Description : 히스토리 View 특이사항은 없다. 다만 opacity background 할 때 BackgroundClearView를 활용하자
*/


// 내일 작업해야 할 것 날짜에 맞는 select만 보여주는 작업을 완료 해야 함.

import SwiftUI

struct History: View {
    
    // Published를 Binding 하기 위해서는 StateObject or ObservedObject 사용
    @StateObject var dateState = DateState()
    @Environment(\.dismiss) var dismiss
    @State var history: [HistModel] = []
    
    var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }
    
    var body: some View {
        NavigationStack {
            
            Section {
                List{
                    ForEach(history, id: \.id) { hist in
                        VStack(alignment: .leading ,content: {
                            Text(hist.symptom)
                                .font(.title3)
                                .bold()
                            
                            Text(hist.vitamins)
                        }) // VStack
                        
                    } // ForEach
                    .padding()
                } // List
            } header: {
                HStack(content: {
                    Text("\(dateFormatter.string(from: dateState.startDate)) ~ \(dateFormatter.string(from: dateState.lastDate))")
                        .padding(.leading, 15)
                    Spacer()
                    Button("기간 설정") {
                        dateState.showDatePicker = true
                    }
                    .padding(.trailing, 15)
                })
                .frame(height: 60)

            } // Section - Header
        } // NavigationStack
        .fullScreenCover(isPresented: $dateState.showDatePicker, content: {
            CustomDateView(dateState: dateState)
                .background(BackgroundClearView())
        }) // ScreenCover
        .onAppear(perform: {
            let sqlite = SQLiteVM()
            history = sqlite.searchDB()
        })
    } // body
} // History

// for background opacity
struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    History()
}
