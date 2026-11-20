//
//  LocationsViewModel.swift
//  SwiftfulMap
//
//  Created by Danish Shaikh on 21/11/26.
//

import Foundation

@Observable
class LocationsViewModel {
    var locations: [Location]
    
    init() {
        self.locations = LocationsDataService.locations
    }
}
