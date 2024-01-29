import SwiftUI
import SwiftData
import UserNotifications

// Custom Yellow
let yellowCustom = Color(red: 1, green: 0.811, blue: 0, opacity: 1.0)

struct ContentView: View {
    //SwiftData
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Task.complete), SortDescriptor(\Task.date, order: .reverse)]) var task: [Task]
    @State private var path = [Task]()
    
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(task) { task in
                    TasksView(task: task)
                        .strikethrough(task.complete)
                        .foregroundColor(task.complete ? .gray : .primary)
                    
                    //Done Gesture
                        .swipeActions(edge: .leading) {
                            if task.complete {
                                Button("Not Done") {
                                    notDone(task: task)
                                }
                                .tint(.yellow)
                            } else {
                                Button("Done") {
                                    done(task: task)
                                }
                                .tint(.green)
                            }
                        }
                }
                //Delete Gesture
                .onDelete(perform: deleteTask)
            }
            .animation(.default, value: task)
            
            //addTask Gesture
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 && abs(value.translation.height) > abs(value.translation.width) {
                            addTask()
                        }
                    }
            )
            .navigationTitle("Tasks")
        }
        .onAppear {
            requestNotificationPermission()
        }
    }
    
    // addTask
    func addTask() {
        let task = Task()
        isEditing = true
        modelContext.insert(task)
    }
    
    // deleteTask
    func deleteTask(_ indexSet: IndexSet) {
        for index in indexSet {
            let task = task[index]
            modelContext.delete(task)
        }
    }
    
    // swipeDone
    func done(task: Task) {
        task.complete = true
    }
    
    // swipeNotDone
    func notDone(task: Task) {
        task.complete = false
    }
    
    //Notifications permission
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Permission granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

//Sort Boolean
extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        // the only true inequality is false < true
        !lhs && rhs
    }
}
