//
//  Post.swift
//  CatGram
//
//  Created by Mac on 2023-10-29.
//

import UIKit

class Post: Hashable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: Int
    let photos: UIImage
    var iconUrl: URL?
    var nick: String
    let dateOfPublication: Date
    var comments: [Comment]
    var amountOfLikes: Int
    var description: String
    var isNew: Bool

    init(id: Int, photos: UIImage, iconUrl: URL?, nick: String, date: Date, comments: [Comment], likes: Int, description: String) {
        self.id = id
        self.photos = photos
        self.dateOfPublication = date
        self.comments = comments
        self.amountOfLikes = likes
        self.description = description
        self.iconUrl = iconUrl
        self.nick = nick
        self.isNew = true
        checkData(dateOfPublication)
    }

    init() {
        self.id = 0
        self.photos = UIImage()
        self.dateOfPublication = Date.now
        self.comments = []
        self.amountOfLikes = 0
        self.description = ""
        self.isNew = false
        self.iconUrl = nil
        self.nick = ""
    }
}

extension Post {
    private func checkData(_ date: Date) {
        let calendar = Calendar.current
        let currentDate = Date.now
        if let differenceInDays = calendar.dateComponents([.day], from: date, to: currentDate).day {
            if differenceInDays <= 4 {
                self.isNew = true
            } else {
                self.isNew = false
            }
        }
    }
}
