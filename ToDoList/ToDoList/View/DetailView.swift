//
//  ItemDetailView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @ObservedObject var item: TodoItem
    @State private var isEditing = false
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    var body: some View {
        VStack(spacing: 16) {
            Text(item.itemDescription ?? "None")
                .font(.title2)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding()
            
            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
                    
                    Text(item.locationName ?? "None")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                    
                    Text("\(item.dueDate ?? Date(), formatter: dateFormatter)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Button(action: {
                item.state.toggle()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: item.state ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Text(item.state ? "Done" : "Open")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
                .background(item.state ? Color.green : Color.blue)
                .cornerRadius(10)
                .padding(.horizontal, 30)
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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
}


