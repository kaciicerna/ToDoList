//
//  AddTodoItemView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI

struct AddTodoItemView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: TodoViewModel
    @Binding var isPresented: Bool
    
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    DatePicker("Due Date", selection: $dueDate)
                }
                
                Section {
                    Button("Add Todo") {
                        viewModel.addTodoItem(title: title, description: description, dueDate: dueDate)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add Todo")
        }
    }
}
