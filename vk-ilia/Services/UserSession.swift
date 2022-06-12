
import Foundation

final class UserSession {
    private init() {}

    static let shared = UserSession() //Глобальная статическая память
    
    var userId: String = ""
    var token: String = ""
    var expiresIn: String = "" //unixtime
}
