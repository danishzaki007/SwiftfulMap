//
//  LocationsView.swift
//  SwiftfulMap
//
//  Created by Danish Shaikh on 08/11/26.
//

import SwiftUI

struct LocationsView: View {
    @State private var viewModel = LocationsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                Text("\(location.name)")
            }
        }
    }
}

#Preview {
    LocationsView()
}
