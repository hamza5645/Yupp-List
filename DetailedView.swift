//
//  DetailedView.swift
//  Yupp(List)
//
//  Created by Hamza Osama on 12/27/23.
//

import SwiftUI
import SwiftData

struct DetailedView: View {
    @Bindable var task: Task
    
    var body: some View {
        VStack {
            TextField("Describe your task", text: $task.discription)
                .padding()
            Spacer()
        }
        .navigationTitle(task.title)
    }
}
