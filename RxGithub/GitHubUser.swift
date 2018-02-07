//
//  User.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import Himotoki

struct GitHubUser {
    let id: Int
    let username: String
    let avatarUrl: String
}

extension GitHubUser: Himotoki.Decodable {
    static func decode(_ e: Extractor) throws -> GitHubUser {
        return try GitHubUser(
            id: e <| "id",
            username: e <| "login",
            avatarUrl: e <| "avatar_url"
        )
    }
}
