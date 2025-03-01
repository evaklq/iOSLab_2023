//
//  UserManager.swift
//  CatGram
//
//  Created by Mac on 2023-11-02.
//

import UIKit

protocol UserManagerProtocol {
    func addUserAsync(_ user: User)
    func autoriseUserAsync(_ nick: String, _ password: String) async -> Bool
    func getAllUsersAsync()
    func deleteUserAsync(nick: String, email: String?, passwordHash: String)
}

class UserManager: UserManagerProtocol {
    private let support = SupportFunctions()
    var users: [User] = []
    lazy var loginedUser: User? = nil
    static let userManager = UserManager()

    private init() {
        createDefaultUsers()
        PostsManager.postsManager.delegateUser = self
        NewsManager.newsManager.delegate = self
    }

    func addUserAsync(_ user: User) {
        Task {
            users.append(user)
            loginedUser = user
        }
    }
    func autoriseUserAsync(_ nick: String, _ password: String) async -> Bool {
        for user in users {
            if user.nick == nick || user.email == nick || user.number == nick {
                if user.passwordHash == support.hashPassword(password) {
                    loginedUser = user
                    return true
                } else {
                    print("password wrong")
                }
            } else {
                print("login wrong")
            }
        }
        return false
    }
    func getAllUsersAsync() {
    }
    func deleteUserAsync(nick: String, email: String?, passwordHash: String) {
    }
}

extension UserManager {
    private func createDefaultUsers() {
        let defaultUsers = self.support.createDefaultUsers()
        self.users = defaultUsers
    }
}

extension UserManager: UpdateUserProtocol {
    func updateUser(posts: [Post]) {
        self.loginedUser?.amountOfPosts -= 1
        self.loginedUser?.posts = posts
    }
}

