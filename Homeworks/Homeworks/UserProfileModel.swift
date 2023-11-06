import Foundation

struct UserProfileModel: Codable {
    var response: [FriendModel]
    
    enum CodingKeys: String, CodingKey {
        case response
    }
}
