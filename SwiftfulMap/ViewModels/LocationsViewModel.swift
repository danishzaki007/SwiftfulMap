//
//  LocationsViewModel.swift
//  SwiftfulMap
//
//  Created by Danish Shaikh on 21/11/26.
//

import Foundation
import MapKit
import SwiftUI

@Observable
class LocationsViewModel {
    // All loaded locations
    var locations: [Location]
    
    // Current location on map
    var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Current region on map
    var mapRegion: MapCameraPosition = .region(MKCoordinateRegion())
    
    // Show list of locations
    var showLocationsList: Bool = false
    
    init() {
        self.locations = LocationsDataService.locations
        self.mapLocation = LocationsDataService.locations.first!
        
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = .region(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
}
