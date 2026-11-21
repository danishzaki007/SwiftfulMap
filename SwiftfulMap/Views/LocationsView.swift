//
//  LocationsView.swift
//  SwiftfulMap
//
//  Created by Danish Shaikh on 21/11/26.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @Environment(LocationsViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ZStack {
            Map(position: $viewModel.mapRegion) {
                ForEach(viewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinates) {
                        LocationMapAnnotationView()
                            .scaleEffect(viewModel.mapLocation == location ? 1: 0.7)
                            .shadow(radius: 10)
                            .onTapGesture {
                                viewModel.showNextLocation(location: location)
                            }
                    }
                }
            }
                .environment(LocationsViewModel())
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()
                
                ZStack {
                    ForEach(viewModel.locations) { location in
                        if (viewModel.mapLocation == location) {
                            LocationPreviewView(location: location)
                                .shadow(color: Color.black.opacity(0.3), radius: 20)
                                .padding()
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                    }
                }
            }
        }
        .sheet(item: $viewModel.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationsView()
        .environment(LocationsViewModel())
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button {
                viewModel.toggleLocationsList()
            } label: {
                Text("\(viewModel.mapLocation.name), \(viewModel.mapLocation.cityName)")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: viewModel.showLocationsList ? "arrow.up" : "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding()
                    }
            }
            .buttonStyle(.plain)
            
            if viewModel.showLocationsList {
                LocationsListView()
                    .environment(viewModel)
            }
            
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}
