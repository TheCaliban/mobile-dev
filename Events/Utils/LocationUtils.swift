import MapKit

class LocationUtils {
    /// Recover the GPS location of a human readable address
    /// - Parameters:
    ///   - address: a human readable existing address
    ///   - completion: callback when the location is resolved
    static func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
                guard error == nil else {
                    print("Geocoding error: \(error!)")
                    completion(nil)
                    return
                }
                
                completion(placemarks?.first?.location?.coordinate)
        }
    }
}
