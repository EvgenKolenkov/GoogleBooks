//
//  User.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 23.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import UIKit

class User {
    
    let name: String
    let eMail: String
    var image: UIImage?
    var imageURL: URL?
    var books = [Book]()

    init(name: String, eMail: String, imageURL: URL) {
        self.name = name
        self.eMail = eMail
        self.imageURL = imageURL
    }
}
