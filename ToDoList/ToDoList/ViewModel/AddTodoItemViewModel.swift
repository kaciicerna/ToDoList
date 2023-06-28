//
//  AddTodoItemViewModel.swift
//  ToDoList
//
//  Created by Kateřina Černá on 28.06.2023.
//

import SwiftUI
import CoreLocation

class AddTodoItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var coordinate: CLLocationCoordinate2D? = nil
    @Published var locationName = ""
    @Published var dueDate = Date()
    @Published var showMapPicker = false
    
    private let geocoder = CLGeocoder()
    
    func addTodoItem(viewModel: TodoViewModel, completion: @escaping () -> Void) {
        viewModel.addTodoItem(title: title, description: description, dueDate: dueDate, latitude: coordinate?.latitude, longitude: coordinate?.longitude, locationName: locationName)
        completion()
    }
    
    func geocodeLocation() {
        geocoder.geocodeAddressString(locationName) { [weak self] placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                print("No coordinates found for the location.")
                return
            }
            
            self?.coordinate = location.coordinate
        }
    }
}

