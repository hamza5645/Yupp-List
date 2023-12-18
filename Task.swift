//
//  Task.swift
//  Yupp(List)
//
//  Created by Hamza Osama on 12/18/23.
//

import Foundation
import SwiftData

@Model
class Task {
    var title: String
    var discription: String
    var sub: String
    var date: Date
    
    init(title: String = "", discription: String = "", sub: String = "", date: Date = .now) {
        self.title = title
        self.discription = discription
        self.sub = sub
        self.date = date
    }
}
