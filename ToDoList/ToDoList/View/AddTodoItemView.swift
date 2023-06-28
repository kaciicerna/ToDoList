//
//  AddTodoItemView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct AddTodoItemView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: TodoViewModel
    @Binding var isPresented: Bool
    @State private var placemark: CLPlacemark? = nil
    
    @State private var title = ""
    @State private var description = ""
    @State private var coordinate: CLLocationCoordinate2D? = nil
    @State private var locationName = ""
    @State private var dueDate = Date()
    @State private var showMapPicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    DatePicker("Due Date", selection: $dueDate)
                }
                
                Section(header: Text("Location")) {
                    Button(action: {
                        showMapPicker = true
                    }) {
                        Text("Select Location")
                    }
                    
                    TextField("Location Name", text: $locationName)
                }
                
                Section {
                    Button(action: {
                        viewModel.addTodoItem(title: title, description: description, dueDate: dueDate, latitude: coordinate?.latitude, longitude: coordinate?.longitude, locationName: locationName)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add ToDo")
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
            .navigationTitle("Add ToDo")
            .sheet(isPresented: $showMapPicker) {
                MapPickerView(coordinate: $coordinate, locationName: $locationName, isPresented: $showMapPicker)
            }
        }
    }
}

struct MapPickerView: View {
    @Binding var coordinate: CLLocationCoordinate2D?
    @Binding var locationName: String
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                MapView(coordinate: $coordinate)
                    .navigationBarTitle("Select Location", displayMode: .inline)
                    .navigationBarItems(
                        trailing: Button(action: {
                            isPresented = false
                        }) {
                            Text("Done")
                                .bold()
                        }
                    )
                
                TextField("Location Name", text: $locationName)
                    .padding()
                    .onChange(of: locationName) { newValue in
                        geocodeLocation()
                    }
            }
        }
    }
    
    private func geocodeLocation() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationName) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                print("No coordinates found for the location.")
                return
            }
            
            coordinate = location.coordinate
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
