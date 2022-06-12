
import Foundation
import Alamofire

protocol FriendsAPIType {
    func getFriends(completion: @escaping(Result<[Friend], Error>)->())
}

final class FriendsAPI: FriendsAPIType {
    
    private let baseURL = "https://api.vk.com/method"
    private let userId = UserSession.shared.userId
    private let token = UserSession.shared.token
    private let version = "5.131"
    
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
            print(response.data?.prettyJSON as Any)

            guard let jsonData = response.data else { return }
            
            do {
                let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: jsonData)
                let friends = friendsResponse.response.items
                completion(friends)
                
            } catch {
                print(error)
            }
        }
    }
}


