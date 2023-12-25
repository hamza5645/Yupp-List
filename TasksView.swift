//
//  TasksView.swift
//  Yupp(List)
//
//  Created by Hamza Osama on 12/18/23.
//

import SwiftUI
import SwiftData

var isEditing: Bool = false

struct TasksView: View {
    @Bindable var task: Task
    
    var body: some View {
        HStack {
            if isEditing {
                TextField("What do you want to do?", text: $task.title)
                    .onSubmit {
                        isEditing = false
                    }
            } else {
                NavigationLink(task.title, destination: DetailedView(task: task))
            }
        }
    }
}
