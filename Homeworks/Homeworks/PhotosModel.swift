import Foundation

struct PhotosModel: Codable {
    var response: PhotosListModel
    
    enum CodingKeys: String, CodingKey {
        case response
    }
}

struct PhotosListModel: Codable {
    var count: Int
    
    var items: [PhotoModel]
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
}

struct PhotoModel: Codable {
    var sizes: [Size]
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

struct Size: Codable {
    var url: String
    var width: Int
    var height: Int
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
        case type
    }
}
