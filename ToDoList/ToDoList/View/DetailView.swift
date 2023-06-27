//
//  ItemDetailView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var item: TodoItem
    @State private var isEditing = false
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    var body: some View {
        VStack(spacing: 16) {
            Text(item.itemDescription ?? "None")
                .font(.body)
                .foregroundColor(.secondary)
            
            Button(action: {
                item.state.toggle()
            }) {
                Text(item.state ? "Done" : "Open")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(item.state ? Color.green : Color.blue)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
        .padding()
        .navigationTitle(item.title ?? "Unknown")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isEditing = true
                }) {
                    Image(systemName: "pencil")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    deleteItem()
                }) {
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
            }
        }
        .sheet(isPresented: $isEditing) {
            EditItemView(item: item, isPresented: $isEditing)
                .environment(\.managedObjectContext, managedObjectContext)
        }
    }
    
    private func deleteItem() {
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to delete item:", error)
        }
    }
}



