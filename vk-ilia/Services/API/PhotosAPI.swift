//
//  PhotosAPI.swift
//  vk-app
//
//  Created by Ilia Zakharov on 28.04.2022.
//

import Foundation
import Alamofire

protocol Photos {
    
}

/*
 https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
 
 https://api.vk.com/method/users.get
 ?user_ids=210700286
 &fields=bdate
 &access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&
 v=5.131
 
 */
protocol PhotosAPIType {
    func getPhotos(completion: @escaping([Photo]) -> ())

}

final class PhotosAPI {
    
    private let baseURL = "https://api.vk.com/method"
    private let myId = UserSession.shared.userId                  // данные берутся из UserSession
    private let token = UserSession.shared.token
    private let version = "5.131"
    
    #warning("Заменить [Photo] на Result<[Photo], Error>")
    func getPhotos(userId: Int, completion: @escaping([Photo]) -> () ) {

        let path = "/photos.getAll"
        let url = baseURL + path

        // параметры из https://vk.com/dev/photos.getAll
        
        print("Inside request = ", userId)
        let params: [String : Any] = [
            "owner_Id" : "\(userId)",
            //"extended" : "1",
            "count" : "10",
            //"photo_sizes" : "1",
            //"no_service_albums" : "1",
            //"need_hidden" : "0",
            //"skip_hidden" : "1",
            "access_token" : token,
            "v" : version
        ]
        
        // запрос
        
        AF.request(url, method: .get, parameters: params).responseData { responseData in
            
            guard let jsonData = responseData.data else { return }
            
            do {
                let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: jsonData)
                
                //получение массива друзей
                let photos: [Photo] = photosResponse.response.items
                completion(photos)
                
            } catch {
                print(error)
            }
        }
        
//        AF.request(url, method: .get, parameters: params).responseJSON { response in
//
//
//            //print(response.data?.prettyJSON)
//
//
//            // Бинарник
//            guard let jsonData = response.data else {return}
//
//            do {
//                let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: jsonData)
//
//                //получение массива друзей
//                let photos: [Photo] = photosResponse.response.items
//                completion(photos)
//
//            } catch {
//                print(error)
//            }
//
//
//        }
    }
}
