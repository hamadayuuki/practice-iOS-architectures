//
//  Repositories.swift
//  APIApp-dependencies
//
//  Created by 濵田　悠樹 on 2023/05/19.
//

public struct Repositories: Decodable {
    var items: [Repository]

    init(id: Int, items: [Repository]) {
        self.items = items
    }
}

public struct Repository: Decodable {
    var id: Int
    var language: String?  // null を含む
    var stargazers_count: Int
    var watchers_count: Int
    var forks_count: Int
    var open_issues_count: Int
    var full_name: String
    var html_url: String
    var updated_at: String
    var owner: Owner

    init(
        id: Int,
        language: String?,
        stargazers_count: Int,
        watchers_count: Int,
        forks_count: Int,
        open_issues_count: Int,
        full_name: String,
        url: String,
        updated_at: String,
        owner: Owner
    ) {
        self.id = id
        self.language = language ?? ""
        self.stargazers_count = stargazers_count
        self.watchers_count = watchers_count
        self.forks_count = forks_count
        self.open_issues_count = open_issues_count
        self.full_name = full_name
        self.html_url = url
        self.updated_at = updated_at
        self.owner = owner
    }
}

public struct Owner: Decodable {
    var id: Int
    var avatar_url: String

    init(id: Int, avatar_url: String) {
        self.id = id
        self.avatar_url = avatar_url
    }
}

