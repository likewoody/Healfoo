//
//  DateState.swift
//  Healfoo
//
//  Created by Woody on 7/8/24.
//  for Custom Date View

import Foundation

class DateState: ObservableObject{
    @Published var startDate = Date()
    @Published var lastDate = Date()
    @Published var showDatePicker: Bool = false
    
    @Published var isStartDate: Bool = false
    @Published var isLastDate: Bool = false
}
