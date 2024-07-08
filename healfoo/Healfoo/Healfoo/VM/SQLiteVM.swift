//
//  SQLiteVM.swift
//  Healfoo
//
//  Created by Woody on 7/8/24.
//

import SwiftUI
import SQLite3

struct SQLiteVM{
    // SQLite3
    var db: OpaquePointer? // pointer
    
    // 없다면 Create query
    init(){
        // userDomainMask = 이 app의 home directory
        // .appending(path: 파일명)
        let fileURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathComponent("healfooHistory.sqlite")
        
        // percent 글자 = 한글
        // c 언어 포인터로 쓰는 방법이라 &db<&의 역할 주소 연산자(위치)>라고 사용한다
        if sqlite3_open(fileURL.path(percentEncoded: true), &db) != SQLITE_OK {
            print("error opening database")
        }
        
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            symptom TEXT,
            vitamins TEXT,
            date TEXT,
        )
        """
        // Table 만들기
        // DOUBLE 대신에 => REAL 사용
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            // error message c언어 스트링
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table\ncode : \(errMsg)")
        }
    }
    
    // search Query
    // SwiftUI에서는 Protocol 사용 대신에 SearchQuery에서 [Student] type으로 바로 return 해준다.
    // 작업처리가 몇번 덜 움직이기 때문에 효율적이다.
    func searchDB() -> [HistoryModel]{
        var hist: [HistoryModel] = []
        
        var stmt: OpaquePointer?
        let queryString = "SELECT * FROM history ORDER BY date DESC"
        
        // 에러가 발생하는지 확인하기 위해서 if문 사용
        // -1 unlimit length 데이터 크기를 의미한다
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table\ncode : \(errMsg)")
        }
        
        // 불러올 데이터가 있다면 불러온다.
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let id = Int(sqlite3_column_int(stmt, 0))
            let symptom = String(cString: sqlite3_column_text(stmt, 1))
            let vitamins = String(cString: sqlite3_column_text(stmt, 2))
            let date = String(cString: sqlite3_column_text(stmt, 3))
            
            hist.append(HistoryModel(id: id, symptom: symptom, vitamins: [vitamins], date: date))
        }
        return hist
    }
    
    
    // insert
    func insertDB(symptom: String, vitamins: [String]) -> Bool{

        var stmt: OpaquePointer?
        
        // 2 bytes의 코드를 쓰는 곳에서 사용함 (한글)
        // -1 unlimit length 데이터 크기를 의미한다
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        let queryString = "INSERT INTO history (symptom, vitamins, date) VALUES (?,?,now())"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        // insert 실행
        // type이 text이기 때문에 bind_text 타입 잘 확인
        sqlite3_bind_text(stmt, 1, symptom, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, vitamins, -1, SQLITE_TRANSIENT)
        
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            print("실패")
            return false
        }
    }
    
    // delete query
    func deleteDB(id: Int) -> Bool{
        var stmt: OpaquePointer?
        
        // 2 bytes의 코드를 쓰는 곳에서 사용함 (한글)
        // -1 unlimit length 데이터 크기를 의미한다
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        let queryString = "DELETE FROM history WHERE id = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        // insert 실행
        // type이 text이기 때문에 bind_text 타입 잘 확인
        sqlite3_bind_int(stmt, 1, Int32(id))
        
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            print("실패")
            return false
        }
    }
}
