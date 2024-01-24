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
    @State private var subCompleted = false
    
    var body: some View {
        VStack {
            HStack {
                checkMarkView
                
                TextField(task.title, text: $task.title)
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            .padding([.leading, .trailing, .bottom])
            
            HStack {
                TextField("Subtask", text: $task.sub)
                    .padding()
                    .strikethrough(subCompleted, color: .gray)
                    .foregroundStyle(subCompleted ? .gray : .primary)
                
                Spacer()
                
                Button {
                    subCompleted.toggle()
                } label: {
                    if subCompleted {
                        Image(systemName: "circle.fill")
                            .padding()
                    } else {
                        Image(systemName: "circle")
                            .padding()
                    }
                }
            }
            
            TextField("Describe your task", text: $task.discription)
                .padding()
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    //CheckMark View
    var checkMarkView: some View {
        ZStack {
            if task.complete {
                Button {
                    task.complete = false
                } label: {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundStyle(.green)
                        .font(.title)
                }
            } else {
                Button {
                    task.complete = true
                } label: {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundStyle(.red)
                        .font(.title)
                }
            }
        }
    }
}
