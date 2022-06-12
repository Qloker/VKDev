//
//  FriendsAPI.swift
//  vk-ilia
//
//  Created by Artur Igberdin on 13.04.2022.
//

import Foundation
import Alamofire

/*
https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

https://api.vk.com/method/users.get?
 user_ids=210700286&
 fields=bdate&
 access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&
 v=5.131
 
 Бинарник -> Dictionary -> Model (Ручной парсинг)
 
 Бинарник -> Codable -> Model (Полуавтоматический)
 */

//Serviceable

protocol FriendsAPIType {
    func getFriends(completion: @escaping(Result<[Friend], Error>)->())
}

//Класс-сервис в котором запросы друзей
final class FriendsAPI: FriendsAPIType {
    
    private let baseURL = "https://api.vk.com/method"
    private let userId = UserSession.shared.userId
    private let token = UserSession.shared.token
    private let version = "5.131"
    
   //https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

//    func getFriends(completion: @escaping([Friend])->()) {
    
    func getFriends(completion: @escaping(Result<[Friend], Error>)->()) {
                
        let path = "/friends.get"

        var urlComponents = URLComponents(string: baseURL + path)
        
        let params: [String : String] = [
            "user_Id" : userId,
            "order" : "random",
            "count" : "50",
            "fields" : "nickname, domain, sex, bdate, city, country, timezone, photo_50",
            "access_token" : token,
            "v" : version
        ]
        
        urlComponents?.queryItems =
        params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        print(urlComponents?.url as Any)

        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let url = urlComponents?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = session.dataTask(with: request) { data, response, error in
            //Background Thread
            print(Thread.current)
            
            if error != nil {
                completion(.failure(error!))
            }
            
            guard let jsonData = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            do {
                let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: jsonData)
                let friends = friendsResponse.response.items
                
                //Ставим задачу асинхронно в очередь в главный поток
                DispatchQueue.main.async {
                    completion(.success(friends))
                }
                
                
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func getFriendsAF(completion: @escaping([Friend])->()) {
        
        let path = "/friends.get"
        
        let url = baseURL + path
        
        let params: [String: String] = [
            "user_id": userId,
            "order": "random",
            "count": "5",
            "fields": "nickname, domain, sex, bdate, city, country, timezone, photo_50",
            "access_token": token,
            "v": version
        ]
        
       
        AF.request(url, method: .get, parameters: params).responseData { response in
            //Main Thread
            
            print(response.data?.prettyJSON as Any)
            
            //Бинарник
            guard let jsonData = response.data else { return }
            
            do {
                let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: jsonData)
                let friends = friendsResponse.response.items
                completion(friends)
                
            } catch {
                print(error)
            }
        }
        //Запрос 
    }
}


