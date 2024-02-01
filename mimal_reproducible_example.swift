//
//  mimal_reproducible_example.swift
//  Yupp(List)
//
//  Created by Hamza Osama on 1/31/24.
//

import SwiftUI

struct mimal_reproducible_example: View {
    
    private struct Tasks: Identifiable {
        var id: String { title }
        var title: String
        var discription: String
        var sub: String
        var date: Date
        var complete: Bool
        var dueDate: Date
    }
    
    private var tasks: [Tasks] = [
        Tasks(title: "Swipe right to complete", discription: "", sub: "", date: .now, complete: false, dueDate: .now),
        Tasks(title: "Swipe left to delete", discription: "", sub: "", date: .now, complete: false, dueDate: .now),
        Tasks(title: "swipe right to mark us uncompleted", discription: "", sub: "", date: .now, complete: true, dueDate: .now)
    ]
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(tasks) { tasks in
                    Text(tasks.title)
                        .strikethrough(tasks.complete)
                        .foregroundColor(tasks.complete ? .gray : .primary)
                        .swipeActions(edge: .leading) {
                            if tasks.complete {
                                Button("Not Done") {
                                    print("Not Done")
                                }
                                .tint(.yellow)
                            } else {
                                Button("Done") {
                                    print("Done")
                                }
                                .tint(.green)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button("Delete") {
                                print("Delete Task")
                            }
                            .tint(.red)
                        }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 && abs(value.translation.height) > abs(value.translation.width) {
                            print("Add Task")
                        }
                    }
            )
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    mimal_reproducible_example()
}
