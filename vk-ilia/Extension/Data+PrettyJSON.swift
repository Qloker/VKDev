//
//  Data+PrettyJSON.swift
//  vk-ilia
//
//  Created by Artur Igberdin on 13.04.2022.
//

import Foundation

//Data - Бинарник
extension Data {
    
    var prettyJSON: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
