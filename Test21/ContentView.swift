import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let name: String
    var isCompleted = false
}

struct TaskList: View {
    @State var tasks = [Task]()
    @State var newTaskName = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New task", text: $newTaskName)
                    Button(action: addTask) {
                        Text("Add")
                    }
                }
                .padding()

                List {
                    ForEach(tasks) { task in
                        TaskRow(task: task)
                    }
                    .onDelete { indexSet in
                        self.tasks.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationBarTitle("Task Manager")
        }
    }

    func addTask() {
        guard !newTaskName.isEmpty else { return }

        tasks.append(Task(name: newTaskName))
        newTaskName = ""
    }
}

struct TaskRow: View {
    let task: Task

    var body: some View {
        HStack {
            Text(task.name)
            Spacer()
            Text(task.isCompleted ? "✅" : "⏺️")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
    }
}
