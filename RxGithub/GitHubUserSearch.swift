//
//  GitHubUserSearch.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import Himotoki

struct GitHubUserSearch {
    let count: Int
    let users: [GitHubUser]
}

extension GitHubUserSearch: Himotoki.Decodable {
    static func decode(_ e: Extractor) throws -> GitHubUserSearch {
        return try GitHubUserSearch(
            count: e <| "total_count",
            users: e <|| "items"
        )
    }
}
