//
//  ItemDetailView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI

struct ItemDetailView: View {
    
    @ObservedObject var item: TodoItem
    
    var body: some View {
        VStack {
            Text(item.title!)
                .font(.title)
                .padding()
            
            Text(item.itemDescription!)
                .padding()
            
            // Add additional details like attachments, location, etc.
        }
        .navigationTitle("Detail")
    }
}

