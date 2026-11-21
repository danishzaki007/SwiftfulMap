//
//  LocationsListView.swift
//  SwiftfulMap
//
//  Created by Danish Shaikh on 21/11/26.
//

import SwiftUI

struct LocationsListView: View {
    @Environment(LocationsViewModel.self) private var viewModel
    
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                Button {
                    viewModel.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    LocationsListView()
}
