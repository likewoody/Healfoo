//
//  ShowDate.swift
//  Healfoo
//
//  Created by Woody on 7/8/24.
//

/*
    Author : Woody Jo
    Date : 24.07.08
    Description : DatePicker View
*/

import SwiftUI

struct ShowDate: View {

    @ObservedObject var dateState: DateState
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack(content: {
                
                // MARK: Date
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(.white)
                    .overlay {
                        VStack(alignment: .trailing, content: {
                            DatePicker("", selection: dateState.isStartDate ? $dateState.startDate : $dateState.lastDate, displayedComponents: [.date])
                                .background(.white)
                            // displayedCompoenets .date 날짜만 선택할 수 있게끔 설정
                                .datePickerStyle(.graphical)
                                .frame(width: 350)
                                .onChange(of: dateState.startDate, {
                                    dateState.isStartDate = false
                                }) // onChange
                                .onChange(of: dateState.lastDate, {
                                    dateState.isLastDate = false
                                }) // onChange
                            
                            HStack(content: {
                                // 취소 버튼
                                confirmButton(okOrCancel: false)
                                
                                // 확인 버튼
                                confirmButton(okOrCancel: true)
                            }) // HStack
                        }) // VStack
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 10))
                    } // overlay
            }) // ZStack
            .background(.white)
            .offset(x: geometry.size.width - geometry.size.width , y: geometry.size.height - geometry.size.height)
        }) // GeometryReader
    } // body
    
    // MARK: Confirm Button
    func confirmButton(okOrCancel: Bool) -> some View{
        return RoundedRectangle(cornerRadius: 15)
            .stroke(.accent)
            .fill(okOrCancel ? .accent : .clear)
            .frame(width: 70, height: 38)
            .overlay {
                Button(okOrCancel ? "확인" : "취소") {
                    if dateState.isStartDate {
                        dateState.isStartDate = false
                    } else {
                        dateState.isLastDate = false
                    }
                } // Button
                .foregroundStyle(okOrCancel ? .white : .accent)
            } // overlay
            .padding(20)
    } // confirmButton
} // ShowDate
