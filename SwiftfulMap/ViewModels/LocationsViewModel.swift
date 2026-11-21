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
    
    // Show location detail via sheet
    var sheetLocation: Location? = nil
    
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
    
    func nextButtonPressed() {
        // Get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation} ) else { return }
        
        let nextIndex = currentIndex + 1
        
        // Check if the currentIndex is valid
        guard locations.indices.contains(nextIndex) else {
            // Next index is NOT valid
            // restart from zero
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next Index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
