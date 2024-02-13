//
//  DetailedView.swift
//  Yupp(List)
//
//  Created by Hamza Osama on 12/27/23.
//

import SwiftUI
import SwiftData
import UserNotifications

struct DetailedView: View {
    @Bindable var task: Task
    @State private var subCompleted = false
    var exclamationmarkSize = 30
    
    var body: some View {
        VStack {
            //Title
            HStack {
                checkMarkView
                
                TextField(task.title, text: $task.title)
                    .font(.title)
                    .bold()
                
                Spacer()
                
                //priority
                HStack{
                    
                    //priority 1
                    Button {
                        if task.priority == 0 {
                            task.priority = 1
                        } else if task.priority == 2 || task.priority == 3 {
                            task.priority = 1
                        } else {
                            task.priority = 0
                        }
                    }label: {
                        if task.priority == 1 || task.priority == 2 || task.priority == 3 {
                            Image(systemName: "exclamationmark")
                                .foregroundStyle(.yellow)
                                .font(.system(size: CGFloat(exclamationmarkSize), weight: .black))
                        } else {
                            Image(systemName: "exclamationmark")
                                .foregroundStyle(.gray.opacity(0.3))
                                .font(.system(size: CGFloat(exclamationmarkSize), weight: .black))
                        }
                    }
                    .animation(.default, value: task.priority)
                    
                    //priority 2
                    Button {
                        if task.priority == 1 || task.priority == 3 || task.priority == 0 {
                            task.priority = 2
                        } else {
                            task.priority = 1
                        }
                    }label: {
                        if task.priority == 2 || task.priority == 3 {
                            Image(systemName: "exclamationmark")
                                .foregroundStyle(.yellow)
                                .font(.system(size: CGFloat(exclamationmarkSize), weight: .black))
                        } else {
                            Image(systemName: "exclamationmark")
                                .foregroundStyle(.gray.opacity(0.3))
                                .font(.system(size: CGFloat(exclamationmarkSize), weight: .black))
                        }
                    }
                    .animation(.default, value: task.priority)
                    
                    //priority 3
                    Button {
                        if task.priority == 2 || task.priority == 1 || task.priority == 0 {
                            task.priority = 3
                        } else {
                            task.priority = 2
                        }
                    }label: {
                        if task.priority == 3 {
                            Image(systemName: "exclamationmark")
                                .foregroundStyle(.yellow)
                                .font(.system(size: CGFloat(exclamationmarkSize), weight: .black))
                        } else {
                            Image(systemName: "exclamationmark")
                                .foregroundStyle(.gray.opacity(0.3))
                                .font(.system(size: CGFloat(exclamationmarkSize), weight: .black))
                        }
                    }
                    .animation(.default, value: task.priority)
                }
            }
            .padding([.leading, .trailing, .bottom])
            
            DatePicker(
                "Due Date",
                selection: $task.dueDate,
                in: Date()...,
                displayedComponents: [.date, .hourAndMinute]
            )
            .padding()
            .datePickerStyle(.compact)
            .onChange(of: task.dueDate) {
                scheduleNotification(date: task.dueDate)
            }
            
            //SubTask
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
            
            //Describtion
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
    
    //Schedule Notifications
    func scheduleNotification(date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Yupp"
        content.body = task.title
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
