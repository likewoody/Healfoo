//
//  CustomBottom.swift
//  Healfoo
//
//  Created by Woody on 7/8/24.
//

/*
    Author : Woody Jo
    Date : 24.07.08
    Description : 히스토리에서 기간 설정을 클릭 시 보여지는 Frame, Date Button, DatePicker 분리
*/

import SwiftUI

struct CustomDateView: View {

    
    @ObservedObject var myState: MyState
    
    var body: some View {
        
        ZStack(content: {
            if myState.showDatePicker {
                Color.black
                    .opacity(0.3)
                
                // separate View
                SetDateFrame(myState: myState)
                
            } // if ~ else
        }) // ZStack
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    } // body
} // CustomBottom


// MARK: SetDate의 Frame
struct SetDateFrame: View {
    @ObservedObject var myState: MyState
    
    var body: some View{
        GeometryReader(content: { geometry in
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.white)
                .frame(width: geometry.size.width / 1.3, height: geometry.size.height / 2.7)
                .offset(x: geometry.size.width - (geometry.size.width * 0.88) , y: geometry.size.height / 3.5)
                .overlay {
                    SetDateContent(myState: myState)
                }
        }) // GeometryReader
        
    } // body

} // SetDate


// MARK: SetDate의 Content
struct SetDateContent: View {
    @ObservedObject var myState: MyState
    
    var body: some View{
        GeometryReader(content: { geometry in
            ZStack(content: {
                VStack(content: {
                    
                    Text("기간 설정")
                        .font(.title3)
                    
                    Divider()
                        .padding(.bottom, 10)
                    
                    startLastView(key: 1)
                    
                    // 이렇게 안하면 화면들이 여러 개가 겹쳐서 보인다.
                    // 시작일을 클릭했을 때 밑에 친구들이 보여서 가려줌
                    if !myState.isStartDate{
                        Divider()
                            .padding([.top, .bottom], 10)
                        
                        
                        startLastView(key: 2)
        
                        if !myState.isLastDate{
                            Divider()
                                .padding([.top, .bottom], 10)
                            
                            RadioButtonView(myState: myState)
                                .padding(.top, 10)
                            
                            ConfirmButton(myState: myState)
                        } // 2차 if
                    } // 1차 if
                }) // VStack
                
            }) // ZStack
            .offset(x: geometry.size.width - (geometry.size.width *  0.85), y: geometry.size.height / 1.2)
            
        }) // GeometryReader
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

    } // body
    
    
    // MARK: 1 = start, 2 = last
    func startLastView(key: Int) -> some View{
        ZStack {
            HStack {
                Text(key == 1 ? "시작일" : "종료일")
                    .font(.system(size: 16))
                    .padding(.leading, 25)
                
                Spacer()
                
                Button(action: {
                    if key == 1 {
                        myState.isStartDate = true
                    } else {
                        myState.isLastDate = true
                    }
                }, label: {
                    Text(key == 1 ? myState.startDate : myState.lastDate, style: .date)
                        .font(.system(size: 16))
                        .padding(.trailing, 10)
                })
            }
            
            // 이렇게 안하면 화면들이 여러 개가 겹쳐서 보인다.
            if key == 1 && myState.isStartDate{
                ShowDate(myState: myState)
            } else if key == 2 && myState.isLastDate {
                ShowDate(myState: myState)
            }
            
        } // ZStack
        
    } // startLastView

    
} // SetDateContent

struct RadioButtonView: View{
    
    @ObservedObject var myState: MyState
    @State var selectedRadio = 2
    
    var body: some View{
        HStack(content: {
            Group{
                Spacer()
                
                // MARK: 1개월
                Button(action: {
                    selectedRadio = 0
                }, label: {
                    
                    whichOneSelectedRadioButton(key: 0)
                }) // 1개월 Button
                
                Text("1개월")
                    .font(.system(size: 14))
                
                Spacer()
                
                
                // MARK: 3개월
                Button(action: {
                    selectedRadio = 1
                }, label: {
                    whichOneSelectedRadioButton(key: 1)
                }) // 3개월 Button
                
                Text("3개월")
                    .font(.system(size: 14))
                
                Spacer()
                
                
                // MARK: 기간설정
                Button(action: {
                    selectedRadio = 2
                }, label: {
                    whichOneSelectedRadioButton(key: 2)

                }) // 기간설정 Button
                                
                Text("기간설정")
                    .font(.system(size: 14))
                
                Spacer()
            } // Group
            
        }) // HStack
    } // body
    
    // MARK: Function
    func whichOneSelectedRadioButton(key: Int) -> some View{
        return RoundedRectangle(cornerRadius: 15)
            .strokeBorder(.accent)
            .foregroundStyle(.white)
            .frame(width: 20, height: 20)
            .overlay {
                if selectedRadio == key {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.gray)
                } // if
            } // overlay
            .onChange(of: selectedRadio) {
                switch selectedRadio{
                case 0:
                    let calendar = Calendar.current
                    myState.startDate = calendar.date(byAdding: .month, value: -1, to: Date())!
                case 1:
                    let calendar = Calendar.current
                    myState.startDate = calendar.date(byAdding: .month, value: -3, to: Date())!
                default:
                    break
                } // switch
            } // onChange
    } // whichOneSelectedRadioButton
    
} // RadioButtonView


// MARK: OK or Cancel
struct ConfirmButton: View{
    @ObservedObject var myState: MyState
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        HStack(content: {
            // 취소 버튼
            confirmButton(okOrCancel: false)
            
            // 확인 버튼
            confirmButton(okOrCancel: true)
            
        }) // HStack
    } // body
    
    // MARK: Confirm Button
    func confirmButton(okOrCancel: Bool) -> some View{
        return RoundedRectangle(cornerRadius: 15)
            .stroke(.accent)
            .fill(okOrCancel ? .accent : .clear)
            .frame(maxWidth: .infinity, maxHeight: 40)
            .overlay {
                Button(okOrCancel ? "확인" : "취소") {
                    if okOrCancel{
                        let sqlite = SQLiteVM()
                        
                        myState.showDatePicker = false
                        myState.history = sqlite.searchDB(startDate: myState.dateFormatter.string(from: myState.startDate), lastDate: myState.dateFormatter.string(from: myState.lastDate))
                    }else {
                        dismiss()
                    }
                } // Button
                .foregroundStyle(okOrCancel ? .white : .accent)
            } // overlay
            .padding(.top, 25)
            .padding(.leading, 5)
    } // confirmButton
} // ConfirmButton
