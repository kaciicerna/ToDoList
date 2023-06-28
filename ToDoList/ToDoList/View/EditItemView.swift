//
//  ItemEditView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI
import MapKit

struct EditItemView: View {
    @ObservedObject var item: TodoItem
    @Binding var isPresented: Bool
    @State private var showMapPicker = false

    @State private var editedTitle: String
    @State private var editedDescription: String
    @State private var editedLocationName: String
    @State private var editedDueDate: Date
    @State private var editedCoordinate: CLLocationCoordinate2D?
    
    @EnvironmentObject private var viewModel: TodoViewModel
    
    init(item: TodoItem, isPresented: Binding<Bool>) {
        self.item = item
        self._isPresented = isPresented
        
        _editedTitle = State(initialValue: item.title ?? "")
        _editedDescription = State(initialValue: item.itemDescription ?? "")
        _editedDueDate = State(initialValue: item.dueDate ?? Date())
        _editedLocationName = State(initialValue: item.locationName ?? "")
        _editedCoordinate = State(initialValue: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $editedTitle)
                    TextField("Description", text: $editedDescription)
                    DatePicker("Due Date", selection: $editedDueDate)
                    HStack {
                        TextField("Location", text: $editedLocationName)
                        Image(systemName: "map")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                showMapPicker = true
                            }
                    }
                }
                
                Section {
                    Button(action: {
                        saveChanges()
                    }) {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                    }
                    .buttonStyle(PlainButtonStyle())
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
        .sheet(isPresented: $showMapPicker) {
            MapPickerView(coordinate: $editedCoordinate, locationName: $editedLocationName, isPresented: $showMapPicker)
        }
    }
    
    private func saveChanges() {
        item.title = editedTitle
        item.itemDescription = editedDescription
        item.dueDate = editedDueDate
        item.locationName = editedLocationName
        
        if let coordinate = editedCoordinate {
            item.latitude = coordinate.latitude
            item.longitude = coordinate.longitude
        }
        
        viewModel.saveContext()
        
        isPresented = false
    }
}



