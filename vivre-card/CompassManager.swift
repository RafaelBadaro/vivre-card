//
//  CompassManager.swift
//  vivre-card
//
//  Created by Rafael Badaró on 11/11/24.
//

import Foundation
import CoreLocation
import SwiftUI


class CompassManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var rotationAngle: Double = 0.0
    @Published var currentLocation: CLLocation?
    @Published var heading: CLHeading?
    

    private var targetLocation = CLLocation(latitude: -23.626578, longitude: -46.659628)
    //CLLocation(latitude: -23.626578, longitude: -46.659628)  // aeroporto congonhas
    //CLLocation(latitude: 37.7749, longitude: -122.4194) // Sao francisco
    //CLLocation(latitude: -19.955136, longitude: -43.952228) // Xus home
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    private func updateRotationAngle(with heading: CLHeading) {
        guard let currentLocation = currentLocation else { return }
        
        // Calculate the bearing from the current location to the target location
        let bearing = currentLocation.bearing(to: targetLocation)
        
        let angle = bearing - heading.magneticHeading
        
        
        // Calculate the angle to rotate by combining the heading and bearing
        rotationAngle = (angle + 360).truncatingRemainder(dividingBy: 360)
    }
    
    // CLLocationManagerDelegate method for location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first {
            currentLocation = newLocation
        }
    }

    // CLLocationManagerDelegate method for heading updates
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        // Update the rotation angle each time the heading changes
        heading = newHeading
        updateRotationAngle(with: newHeading)
    }
}

// Extension to calculate the bearing between two CLLocation objects
extension CLLocation {
    func bearing(to destination: CLLocation) -> Double {
        let lat1 = self.coordinate.latitude * .pi / 180
        let lon1 = self.coordinate.longitude * .pi / 180
        let lat2 = destination.coordinate.latitude * .pi / 180
        let lon2 = destination.coordinate.longitude * .pi / 180
        
        let deltaLon = lon2 - lon1
        let y = sin(deltaLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(deltaLon)
        
        let bearing = atan2(y, x) * 180 / .pi
        return (bearing + 360).truncatingRemainder(dividingBy: 360)  // Normalize to 0-360 degrees
    }
}


