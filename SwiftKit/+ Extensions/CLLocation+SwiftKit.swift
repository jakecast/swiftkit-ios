import CoreLocation

public extension CLLocation {
    static func latestLocation(#locations: [AnyObject]) -> CLLocation? {
        return locations
            .map({ return $0 as? CLLocation })
            .filter({ return $0 != nil })
            .map({ return $0! })
            .sorted({ return $0.timestamp.timeInterval < $1.timestamp.timeInterval })
            .lastItem()
    }
}

public extension CLLocation {
    var latitude: CLLocationDegrees {
        return self.coordinate.latitude
    }

    var longitude: CLLocationDegrees {
        return self.coordinate.longitude
    }
    
    convenience init(coordinates: (CLLocationDegrees, CLLocationDegrees), round: Int?=nil) {
        if let precision = round {
            self.init(
                latitude: coordinates.0.round(precision: precision),
                longitude: coordinates.1.round(precision: precision)
            )
        }
        else {
            self.init(
                latitude: coordinates.0,
                longitude: coordinates.1
            )
        }
    }

    convenience init(coordinates: CLLocationCoordinate2D) {
        self.init(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    func round(precision: Int=0) -> CLLocation {
        return CLLocation(latitude: self.latitude.round(precision: precision), longitude: self.longitude.round(precision: precision))
    }
}