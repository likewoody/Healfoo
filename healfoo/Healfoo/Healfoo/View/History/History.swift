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

import SwiftUI

struct History: View {
    
    // Published를 Binding 하기 위해서는 StateObject or ObservedObject 사용
    @StateObject var dateState = DateState()
    @Environment(\.dismiss) var dismiss
    @State var history: [HistoryModel] = []
    
    var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }
    
    var body: some View {
        NavigationStack {
            HStack(content: {
                Text("\(dateFormatter.string(from: dateState.startDate)) ~ \(dateFormatter.string(from: dateState.lastDate))")
                    .padding(.leading, 30)
                
                Spacer()
                
                Button("기간 설정") {
                    dateState.showDatePicker = true
                }
                .padding(.trailing, 30)
            })
            
//            List{
//                ForEach(history, id: \.id) { hist in
//                    Text(hist.symptom)
//                    ForEach(history.vitamins) { vitamin in
//                        Text(vitamin)
//                    }
//                }
//            }
            
                
                 
//                ForEach(history, id: \.id) { hist in
//                    VStack(content: {
//                        Text(hist.symptom)
//                        
//                        Text(hist.vitamins)
//                    }) // VStack
//                } // ForEach
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
