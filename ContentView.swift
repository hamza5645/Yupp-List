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
    let firstLaunchKey = "hasLaunchedBefore"
    
    
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
            checkFirstLaunch()
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
    
    //Checks if user launched the app before
    func checkFirstLaunch() {
        if !UserDefaults.standard.bool(forKey: firstLaunchKey) {
            // First launch, initialize tasks
            initializeTasksWithCustom()

            // Set the flag to true so this doesn't run again
            UserDefaults.standard.set(true, forKey: firstLaunchKey)
        }
    }

    
    //Guide tasks
    func initializeTasksWithCustom() {
        let customTask1 = Task()
        customTask1.title = "swipe right to mark us uncompleted"
        customTask1.complete = true

        let customTask2 = Task()
        customTask2.title = "Swipe right to complete"

        let customTask3 = Task()
        customTask3.title = "Swipe left to delete"

        modelContext.insert(customTask1)
        modelContext.insert(customTask2)
        modelContext.insert(customTask3)

        try? modelContext.save()
    }
}

//Sort Boolean
extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        // the only true inequality is false < true
        !lhs && rhs
    }
}
