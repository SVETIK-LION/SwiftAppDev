import Foundation

final class GroupsDataService {
    private var userDefaults = UserDefaults.standard
    
    func putData(groups: [GroupModel]){
        for (index, group) in groups.enumerated() {
            userDefaults.set(group.name, forKey: "name" + String(index))
            userDefaults.set(group.description, forKey: "description" + String(index))
            userDefaults.set(group.photoURL, forKey: "photoURL" + String(index))
        }
    }
    
    func getData() -> [GroupModel] {
        var groups: [GroupModel] = []
        var index = 0
        var isExist = userDefaults.string(forKey: "name0") != nil
        while isExist {
            groups.append(GroupModel(name: userDefaults.string(forKey: "name" + String(index)) ?? "",
                                     description: userDefaults.string(forKey: "description" + String(index)) ?? "",
                                     photoURL: "photoURL" + String(index)))
            index += 1
            isExist = userDefaults.string(forKey: "name" + String(index)) != nil
        }
        return groups
    }
}

final class FriendsDataService {
    private var userDefaults = UserDefaults.standard
    
    func putData(friends: [FriendModel]){
        for (index, friend) in friends.enumerated() {
            userDefaults.set(friend.firstName, forKey: "firstName" + String(index))
            userDefaults.set(friend.lastName, forKey: "lastName" + String(index))
            userDefaults.set(friend.photoURL, forKey: "photoURL" + String(index))
        }
    }
    
    func getData() -> [FriendModel] {
        var friends: [FriendModel] = []
        var index = 0
        var isExist = userDefaults.string(forKey: "firstName0") != nil
        while isExist {
            friends.append(FriendModel(firstName: userDefaults.string(forKey: "firstName" + String(index)) ?? "",
                                       lastName: userDefaults.string(forKey: "lastName" + String(index)) ?? "",
                                       photoURL: "photoURL" + String(index)))
            index += 1
            isExist = userDefaults.string(forKey: "firstName" + String(index)) != nil
        }
        return friends
    }
}
