//
//  MapView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 28.06.2023.
//

import SwiftUI
import MapKit
import CoreLocation

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
                HStack(spacing: 5) {
                    Image(systemName: "magnifyingglass")
                    TextField("Location Name", text: $locationName)
                        .onChange(of: locationName) { newValue in
                            geocodeLocation()
                        }
                }
                .padding()
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

