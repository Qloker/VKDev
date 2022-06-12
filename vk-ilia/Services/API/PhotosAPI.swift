
import Foundation
import Alamofire

protocol Photos {
    
}

protocol PhotosAPIType {
    func getPhotos(completion: @escaping([Photo]) -> ())

}

final class PhotosAPI {
    
    private let baseURL = "https://api.vk.com/method"
    private let myId = UserSession.shared.userId
    private let token = UserSession.shared.token
    private let version = "5.131"
    
    #warning("Заменить [Photo] на Result<[Photo], Error>")
    func getPhotos(userId: Int, completion: @escaping([Photo]) -> () ) {

        let path = "/photos.getAll"
        let url = baseURL + path

        
        print("Inside request = ", userId)
        let params: [String : Any] = [
            "owner_Id" : "\(userId)",
            "count" : "10",
            "access_token" : token,
            "v" : version
        ]
    
        AF.request(url, method: .get, parameters: params).responseData { responseData in
            
            guard let jsonData = responseData.data else { return }
            
            do {
                let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: jsonData)
                let photos: [Photo] = photosResponse.response.items
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
}
