import Foundation
import SwiftUI

struct RootSpeaker: Decodable {
    let speakers : [Speaker]
    enum CodingKeys: String, CodingKey {
        case speakers = "records"
    }
}

struct Speaker: Hashable, Codable, Identifiable {
    var id: String
    var fields: SpeakerFields
    var createdTime: Date
}

struct SpeakerFields: Hashable, Codable {
    var name: String
    var role: String
    var email: String?
    var phone: String?
    
    var type: String
    var status: String?
    
    var company: [String]
    var speakingAt: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case role = "Role"
        case email = "Email"
        case phone = "Phone"
        case type = "Type"
        case status = "Status"
        case company = "Company"
        case speakingAt = "Speaking at"
    }
}
