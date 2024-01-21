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
            HStack {
                checkMarkView
                
                TextField(task.title, text: $task.title)
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            .padding([.leading, .trailing, .bottom])
            Spacer()
            
            //Info
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    //CheckMark View
    var checkMarkView: some View {
        ZStack {
            if task.complete {
                Image(systemName: "checkmark.square.fill")
                    .foregroundStyle(.green)
                    .font(.title)
            } else {
                Image(systemName: "checkmark.square.fill")
                    .foregroundStyle(.red)
                    .font(.title)
            }
        }
    }
}
