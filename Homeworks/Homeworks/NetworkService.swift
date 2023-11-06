import Foundation

final class NetworkService: NetworkServiceProtocol {
    private var session = URLSession.shared
    
    private static var userID: String = ""
    
    private static var userToken: String = ""
    
    private var request = URLRequest(url: URL(string: "https://oauth.vk.com/authorize?client_id=51679394&scope=262150&redirect_uri=https://vk.com/away.php?to=https://oauth.vk.com/blank.html&display=mobile&response_type=token")!)
    
    func getAuthorizeRequest() -> URLRequest {
        return request
    }
    
    func receiveIDandToken(fragment: String){
        let params = fragment
            .components(separatedBy: "&")
            .map {$0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        NetworkService.userToken = params["access_token"] ?? ""
        NetworkService.userID = params["user_id"] ?? ""
    }
    
    func getFriends(handler: @escaping ([FriendModel]) -> Void){
        let url: URL? = URL(string: "https://api.vk.com/method/friends.get?fields=photo_50&user_id=" + NetworkService.userID + "&access_token=" + NetworkService.userToken + "&v=5.131")
        
        session.dataTask(with: url!) { (data,_,error) in
            guard let data = data else {
                return
            }
            do {
                let friendsList = try JSONDecoder().decode(FriendsModel.self, from: data)
                handler(friendsList.response.items)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroups(handler: @escaping ([GroupModel]) -> Void){
        let url: URL? = URL(string: "https://api.vk.com/method/groups.get?extended=1&fields=description&user_id=" + NetworkService.userID + "&access_token=" + NetworkService.userToken + "&v=5.131")
        
        session.dataTask(with: url!) { (data,_,error) in
            guard let data = data else {
                return
            }
            do {
                let groupsList = try JSONDecoder().decode(GroupsModel.self, from: data)
                handler(groupsList.response.items)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getPhotos(handler: @escaping ([PhotoModel]) -> Void){
        let url: URL? = URL(string: "https://api.vk.com/method/photos.get?photo_sizes=1&album_id=profile&owner_id=" + NetworkService.userID + "&access_token=" + NetworkService.userToken + "&v=5.131")
        
        session.dataTask(with: url!) { (data,_,error) in
            guard let data = data else {
                return
            }
            do {
                let photosList = try JSONDecoder().decode(PhotosModel.self, from: data)
                handler(photosList.response.items)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getUserProfile(handler: @escaping ([FriendModel]) -> Void){
        let url: URL? = URL(string: "https://api.vk.com/method/users.get?fields=photo_50,first_name,last_name" + "&access_token=" + NetworkService.userToken + "&v=5.131")
        
        session.dataTask(with: url!) { (data,_,error) in
            guard let data = data else {
                return
            }
            do {
                let userProfile = try JSONDecoder().decode(UserProfileModel.self, from: data)
                handler(userProfile.response)
            } catch {
                print(error)
            }
        }.resume()
    }
}

protocol NetworkServiceProtocol: AnyObject {
    func getAuthorizeRequest() -> URLRequest
}
