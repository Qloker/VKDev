//
//  GroupsAPI.swift
//  vk-ilia
//
//  Created by Ilia Zakharov on 08.05.2022.
//

import Foundation
import Alamofire

//protocol Photos {
//
//}
/*
 
 https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
 
 https://api.vk.com/method/users.get
 ?user_ids=210700286
 &fields=bdate
 &access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&
 v=5.131
 
 */
//protocol GroupsAPIType {
//    func getGroups(completion: @escaping([Photo]) -> ())
//
//}

final class GroupsAPI {
    
    private let baseURL = "https://api.vk.com/method"
    private let myId = UserSession.shared.userId // данные берутся из UserSession
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

            
            // Бинарник
            guard let jsonData = response.data else {return}

            do {
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: jsonData)

                //получение массива друзей
                let groups: [Group] = groupsResponse.response.items
                completion(groups)

            } catch {
                print(error)
            }
            
           
        }
    }
}
