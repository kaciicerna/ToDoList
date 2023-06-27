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
        }
        .sheet(isPresented: $isEditing) {
            EditItemView(item: item, isPresented: $isEditing)
        }
    }
}


