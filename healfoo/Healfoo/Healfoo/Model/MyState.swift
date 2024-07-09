//
//  DateState.swift
//  Healfoo
//
//  Created by Woody on 7/8/24.
//  for Custom Date View

import Foundation

class MyState: ObservableObject{
    @Published var startDate = Date()
    @Published var lastDate = Date()
    @Published var showDatePicker: Bool = false
    
    @Published var isStartDate: Bool = false
    @Published var isLastDate: Bool = false
    
    @Published var history: [HistModel] = []
    
    var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }
    
    let sqlite = SQLiteVM()
}
