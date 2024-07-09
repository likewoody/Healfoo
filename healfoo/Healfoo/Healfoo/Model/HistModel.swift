//
//  History.swift
//  Healfoo
//
//  Created by Woody on 7/8/24.
//

import Foundation

struct HistModel{
    var id: Int
    var symptom: String
    var vitamins: String
    var date: String
    
    init(id: Int, symptom: String, vitamins: String, date: String) {
        self.id = id
        self.symptom = symptom
        self.vitamins = vitamins
        self.date = date
    }
}
extension HistModel: Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
