import SwiftUI
import SwiftData

// Custom Yellow
let yellowCustom = Color(red: 1, green: 0.811, blue: 0, opacity: 1.0)

struct ContentView: View {
    //SwiftData
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Task.date, order: .reverse) var task: [Task]
    @State private var path = [Task]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(task) { task in
                    TasksView(task: task)
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
            .toolbar {
                Button("Add Task", action: addTask)
            }
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
}
