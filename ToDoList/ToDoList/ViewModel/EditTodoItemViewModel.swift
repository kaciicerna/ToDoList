//
//  EditTodoItemViewModel.swift
//  ToDoList
//
//  Created by Kateřina Černá on 28.06.2023.
//

import Foundation
import MapKit

class EditTodoItemViewModel: ObservableObject {
    @Published var editedTitle: String
    @Published var editedDescription: String
    @Published var editedLocationName: String
    @Published var editedDueDate: Date
    @Published var editedCoordinate: CLLocationCoordinate2D?
    @Published var showMapPicker = false
    
    init(item: TodoItem) {
        editedTitle = item.title ?? ""
        editedDescription = item.itemDescription ?? ""
        editedDueDate = item.dueDate ?? Date()
        editedLocationName = item.locationName ?? ""
        editedCoordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
    }
    
}

