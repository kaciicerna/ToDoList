//
//  TodoListItemView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI

struct TodoListItemView: View {
    
    @ObservedObject var item: TodoItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if item.state {
                Text(item.title ?? "Unknown")
                    .font(.title2)
                    .foregroundColor(.red)
                    .strikethrough() // Add strikethrough for "Done" state
            } else {
                Text(item.title ?? "Unknown")
                    .font(.title2)
                    .fontWeight(item.state ? .regular : .bold)
            }
            
            Text(item.itemDescription ?? "No description")
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .padding()
    }
}

