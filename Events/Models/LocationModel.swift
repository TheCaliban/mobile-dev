import Foundation

struct Location: Hashable, Codable, Identifiable {
    var id: String
    var createdTime: Date
    var fields: LocationFields
    
}

struct LocationFields: Hashable, Codable {
    var description: String
    
    var spaceName: String
    
    var buildingLocation: String
    var scheduledEvents: Array<String>
    
    var maxCapacity: Int

    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case spaceName = "Space name"
        case buildingLocation = "Building location"
        case scheduledEvents = "Scheduled events"
        case maxCapacity = "Max capacity"
    }
}
