import Foundation

struct FriendsModel: Codable {
    var response: FriendsListModel
    
    enum CodingKeys: String, CodingKey {
        case response
    }
}

struct FriendsListModel: Codable {
    var items: [FriendModel]
}

struct FriendModel: Codable {
    
    var firstName: String?
    var lastName: String?
    var photoURL: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photoURL = "photo_50"
    }
}


