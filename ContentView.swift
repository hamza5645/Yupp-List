import SwiftUI
import SwiftData

// Custom Yellow
let yellowCustom = Color(red: 1, green: 0.811, blue: 0, opacity: 1.0)

struct ContentView: View {
    //SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var task: [Task]
    @State private var path = [Task]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(task) { task in
                    Text(task.title)
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Tasks")
            .toolbar {
                Button("Add Task", action: addTask)
            }
        }
    }
    
    // addTask
    func addTask() {
        let task = Task()
        modelContext.insert(task)
    }
    
    // deleteTask
        func deleteTask(_ indexSet: IndexSet) {
            for index in indexSet {
                let task = task[index]
                modelContext.delete(task)
            }
        }
}
