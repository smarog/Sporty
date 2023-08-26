//
//  SportyServices.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import Foundation

class SportyServices: Service {
    var baseURL: String {
        return "https://618d3aa7fe09aa001744060a.mockapi.io/api"
    }


    var path: String {
        return "/sports"
    }


    var method: ServiceMethod {
        return .get
    }
}
