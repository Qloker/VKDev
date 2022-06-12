//
//  User.swift
//  vk-ilia
//
//  Created by Artur Igberdin on 06.04.2022.
//

import Foundation

//Синглтон - объект который имеет глобальную точку доступа

#warning("Сервис который занимается токеном - отслеживать то что токен не просрочен и хранить в UserDefaults")

final class UserSession {
    
    private init() {}
    
    static let shared = UserSession() //Глобальная статическая память
    
    var userId: String = ""
    var token: String = ""
    var expiresIn: String = "" //unixtime
}
