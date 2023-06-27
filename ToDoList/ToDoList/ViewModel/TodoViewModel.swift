//
//  TodoViewModel.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI
import CoreData

class TodoViewModel: ObservableObject {
    @Published var todoItems: [TodoItem] = []
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    init() {
        fetchTodoItems()
    }
    
    func fetchTodoItems() {
        let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        do {
            todoItems = try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching todo items: \(error)")
        }
    }
    
    func addTodoItem(title: String, description: String, dueDate: Date, latitude: Double?, longitude: Double?) {
        let newItem = TodoItem(context: viewContext)
        newItem.title = title
        newItem.itemDescription = description
        newItem.dueDate = dueDate
        newItem.latitude = latitude ?? 0.0
        newItem.longitude = longitude ?? 0.0

        saveContext()
    }

    
    func deleteTodoItem(indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = todoItems[index]
            viewContext.delete(item)
        }
        
        saveContext()
    }
    
    internal func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        fetchTodoItems()
    }
}

