import Foundation

public struct Customer: Codable {
    var longitude: String
    var latitude: String
    var name: String
    var userId: Int
    var latRadian: Double?
    var longRadian: Double?

    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
        case name
        case userId = "user_id"
        case latRadian
        case longRadian
    }
}

