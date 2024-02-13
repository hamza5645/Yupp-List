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
    var complete: Bool
    var dueDate: Date
    var priority: Int
    
    init(title: String = "", discription: String = "", sub: String = "", date: Date = .now, complete: Bool = false, dueDate: Date = .now, priority: Int = 0) {
        self.title = title
        self.discription = discription
        self.sub = sub
        self.date = date
        self.complete = complete
        self.dueDate = dueDate
        self.priority = priority
    }
}
