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
                    .strikethrough()
            } else {
                Text(item.title ?? "Unknown")
                    .font(.title2)
                    .fontWeight(item.state ? .regular : .bold)
            }
            
            Text(item.itemDescription ?? "No description")
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
            
            if let dueDate = item.dueDate {
                Text("\(dueDate, formatter: dateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
        )
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}






