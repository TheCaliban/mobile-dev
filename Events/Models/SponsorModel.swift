import Foundation
import SwiftUI

struct RootSponsors: Decodable {
    let sponsors : [Sponsor]
    enum CodingKeys: String, CodingKey {
        case sponsors = "records"
    }
}

struct Sponsor: Hashable, Codable, Identifiable {
    var id: String
    var createdTime: Date
    var fields: SponsorFields
}

struct SponsorFields: Hashable, Codable {
    var name:String
    var description: String?
    var status: String
    
    var contactsId: [String]?
    
    var previousSponsor: Bool?
    var sponsoredAmount: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "Company"
        case description = "Notes"
        case status = "Status"
        case contactsId = "Contact(s)"
        case previousSponsor = "Previous sponsor"
        case sponsoredAmount = "Sponsored amount"
    }
}
