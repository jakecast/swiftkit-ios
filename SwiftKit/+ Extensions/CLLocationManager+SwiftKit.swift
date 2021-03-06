import CoreLocation

public extension CLLocationManager {
    func requestAuthorizationAlways() -> Self {
        self.requestAlwaysAuthorization()
        return self
    }

    func requestAuthorizationWhenInUse() -> Self {
        self.requestWhenInUseAuthorization()
        return self
    }

    func set(#activityType: CLActivityType) -> Self {
        self.activityType = activityType
        return self
    }

    func set(#delegate: CLLocationManagerDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    func set(#desiredAccuracy: CLLocationAccuracy) -> Self {
        self.desiredAccuracy = desiredAccuracy
        return self
    }

    func set(#distanceFilter: CLLocationDistance) -> Self {
        self.distanceFilter = distanceFilter
        return self
    }

    func set(#pausesLocationUpdatesAutomatically: Bool) -> Self {
        self.pausesLocationUpdatesAutomatically = pausesLocationUpdatesAutomatically
        return self
    }
}