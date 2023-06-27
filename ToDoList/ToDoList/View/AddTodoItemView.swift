//
//  AddTodoItemView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI
import MapKit

struct AddTodoItemView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: TodoViewModel
    @Binding var isPresented: Bool
    
    @State private var title = ""
    @State private var description = ""
    @State private var coordinate: CLLocationCoordinate2D? = nil
    @State private var dueDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    DatePicker("Due Date", selection: $dueDate)
                }
                
                Section(header: Text("Location")) {
                    MapView(coordinate: $coordinate)
                        .frame(height: 200)
                        .cornerRadius(10)
                }
                
                Section {
                    Button("Add Todo") {
                        viewModel.addTodoItem(title: title, description: description, dueDate: dueDate, latitude: coordinate?.latitude, longitude: coordinate?.longitude)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add ToDo")
        }
    }
}

struct MapView: UIViewRepresentable {
    @Binding var coordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if let coordinate = coordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            parent.coordinate = view.annotation?.coordinate
        }
    }
}
