//
//  ApiConstants.swift
//  Repositories
//
//  Created by Elizeus on 13/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import Foundation
import Alamofire

let gitApiUrl = "https://api.github.com"
let userPath = "/users/Inza/repos"
let detailsPath = "/repos/Inza/"

let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json"]

let baseUrl = "\(gitApiUrl)\(userPath)"
let detailsUrl = "\(gitApiUrl)\(detailsPath)"
