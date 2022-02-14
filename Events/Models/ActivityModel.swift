import Foundation
import SwiftUI

struct Root: Decodable {
    let activities : [Activity]
    enum CodingKeys: String, CodingKey {
        case activities = "records"
    }
}

struct Activity: Hashable, Codable, Identifiable {
    var id: String
    var createdTime: Date
    var fields: ActivityFields
    
}

struct ActivityFields: Hashable, Codable {
    var type: String
    
    var startDate: Date
    var endDate	: Date
    
    var name:String
    var description: String?
    
    var locationId: [String]?
    var speakersId: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "Activity"
        case description = "Notes"
        case type = "Type"
        case startDate = "Start"
        case endDate = "End"
        case locationId = "Location"
        case speakersId = "Speaker(s)"
    }
}
