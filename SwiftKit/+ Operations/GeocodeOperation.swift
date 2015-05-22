import Foundation
import CoreLocation

public class GeocodeOperation: BaseOperation {
    private var coordinates: CLLocation? = nil
    private var geocoder: CLGeocoder? = nil
    private var geocodePlacemarks: [CLPlacemark]? = nil
    private var geocodeError: NSError?

    public override func start() {
        super.start()
        self.startGeocode()
            .updateExecutingStatus()
    }

    public func geocodeResults() -> ([CLPlacemark]?, NSError?) {
        return (self.geocodePlacemarks, self.geocodeError)
    }

    public func set(#coordinates: CLLocation) -> Self {
        self.coordinates = coordinates
        return self
    }

    private func startGeocode() -> Self {
        if let geocodeCoordinates = self.coordinates {
            self.geocoder = CLGeocoder()
            self.geocoder?.reverseGeocode(
                location: geocodeCoordinates,
                completionHandler: { self.finishGeocode($0, $1) }
            )
        }
        return self
    }

    private func finishGeocode(placemarks: [CLPlacemark]?, _ error: NSError?) {
        if self.cancelled == false {
            self.geocodePlacemarks = placemarks
            self.geocodeError = error
        }
        
        self.geocoder = nil
        self.updateExecutingStatus()
    }

    private func updateExecutingStatus() {
        self.set(executing: self.geocoder != nil)
    }
}