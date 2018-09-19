//
//  Books.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 23.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import Foundation
import UIKit

class Book: Equatable {
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
    
    
    var title: String
    var authors: [String]
    var info: String
    var image: UIImage?
    var imageURL: URL?
    
    init (title: String, authors: [String], info: String) {
        self.title = title
        self.info = info
        self.authors = authors
    }
}
