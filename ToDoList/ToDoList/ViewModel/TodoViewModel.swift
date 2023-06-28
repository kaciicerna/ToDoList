//
//  TodoViewModel.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI
import CoreData
import LocalAuthentication

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
    
    func addTodoItem(title: String, description: String, dueDate: Date, latitude: Double?, longitude: Double?, locationName: String) {
        let newItem = TodoItem(context: viewContext)
        newItem.title = title
        newItem.itemDescription = description
        newItem.dueDate = dueDate
        newItem.latitude = latitude ?? 0.0
        newItem.longitude = longitude ?? 0.0
        newItem.locationName = locationName

        saveContext()
    }

    
    func deleteTodoItem(indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = todoItems[index]
            viewContext.delete(item)
        }
        
        saveContext()
    }
    
    func deleteTodoItem(item: TodoItem) {
        if let index = todoItems.firstIndex(of: item) {
            todoItems.remove(at: index)
        }
    }
    
    internal func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        fetchTodoItems()
    }
    
    func authenticateWithFaceID(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Use Face ID authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock your app") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        } else {
            completion(false)
        }
    }

}

