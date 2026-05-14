//
//  Constants.swift
//  SportsApplication
//
//  Created by Moaz on 09/05/2026.
//

import Foundation

struct Constants {
    static let baseURL = "https://apiv2.allsportsapi.com"
    static var apiKey: String {
            guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
                fatalError("API_KEY not found")
            }
            return key
    }
}
