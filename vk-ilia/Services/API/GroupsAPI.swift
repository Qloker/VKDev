
import Foundation
import Alamofire

final class GroupsAPI {
    
    private let baseURL = "https://api.vk.com/method"
    private let myId = UserSession.shared.userId
    private let token = UserSession.shared.token
    private let version = "5.131"
    

    func getGroups(userId: Int, completion: @escaping([Group]) -> () ) {

        let path = "/groups.get"
        let url = baseURL + path

        let params: [String : Any] = [
            "user_Id" : userId,
            "extended" : "1",
            "fields" : "description",
            "filter" : "publics",
            "count" : "7",
            "access_token" : token,
            "v" : version
        ]

        AF.request(url, method: .get, parameters: params).responseData { response in
            print(response.data?.prettyJSON as Any)
            
            guard let jsonData = response.data else {return}
            do {
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: jsonData)
                let groups: [Group] = groupsResponse.response.items
                completion(groups)
            } catch {
                print(error)
            }
        }
    }
}
