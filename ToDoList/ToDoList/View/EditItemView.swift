//
//  ItemEditView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI

struct EditItemView: View {
    @ObservedObject var item: TodoItem
    @Binding var isPresented: Bool
    
    @State private var editedTitle: String
    @State private var editedDescription: String
    
    @EnvironmentObject private var viewModel: TodoViewModel
    
    init(item: TodoItem, isPresented: Binding<Bool>) {
        self.item = item
        self._isPresented = isPresented
        
        _editedTitle = State(initialValue: item.title ?? "")
        _editedDescription = State(initialValue: item.itemDescription ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $editedTitle)
                    TextField("Description", text: $editedDescription)
                }
                
                Section {
                    Button("Save") {
                        saveChanges()
                    }
                }
            }
            .navigationTitle("Edit Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    private func saveChanges() {
        item.title = editedTitle
        item.itemDescription = editedDescription
        
        viewModel.saveContext()  // Save changes using the TodoViewModel
        
        isPresented = false
    }
}
