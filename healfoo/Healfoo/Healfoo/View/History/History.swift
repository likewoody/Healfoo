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
    @StateObject var myState = MyState()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Section {
                List{
                    ForEach(myState.history, id: \.id) { hist in
                        VStack(alignment: .leading ,content: {
                            Text(hist.symptom)
                                .font(.title3)
                                .bold()
                            
                            Text(hist.vitamins)
                        }) // VStack
                        
                    } // ForEach
                    .onDelete(perform: { indexSet in
                        // 삭제할 항목들의 ID를 먼저 수집합니다
                        let idsToDelete = indexSet.map { myState.history[$0].id }
                        
                        // 로컬 데이터에서 항목을 제거합니다
                        myState.history.remove(atOffsets: indexSet)
                        
                        // 데이터베이스에서 항목을 삭제합니다
                        for id in idsToDelete {
                            print(id)
                            _ = myState.sqlite.deleteDB(id: id)
                        }
                    })
                    .padding()
                } // List
            } header: {
                HStack(content: {
                    Text("\(myState.dateFormatter.string(from: myState.startDate)) ~ \(myState.dateFormatter.string(from: myState.lastDate))")
                        .padding(.leading, 15)
                    Spacer()
                    Button("기간 설정") {
                        myState.showDatePicker = true
                    }
                    .padding(.trailing, 15)
                })
                .frame(height: 60)

            } // Section - Header
        } // NavigationStack
        .fullScreenCover(isPresented: $myState.showDatePicker, content: {
            CustomDateView(myState: myState)
                .background(BackgroundClearView())
        }) // ScreenCover
        .onAppear(perform: {
            let sqlite = SQLiteVM()
            
            myState.history = sqlite.searchDB(
                startDate: myState.dateFormatter.string(from: myState.startDate),
                lastDate: myState.dateFormatter.string(from: myState.lastDate)
            )
        }) // onAppear
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
