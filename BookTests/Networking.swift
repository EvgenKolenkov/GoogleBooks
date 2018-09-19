//
//  Networking.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 23.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

//https://www.googleapis.com/books/v1/volumes
import Foundation
import UIKit

class Networking {
    
    class func getBooksFromAPI(_ searchText: String) {
        
        let endpoint: String = "https://www.googleapis.com/books/v1/volumes"
        
        var query = URLComponents(string: endpoint)
        let queryItems = [URLQueryItem.init(name: "key", value: "AIzaSyCHv0dKTdp7ma2tKaQ0-vcPsD80mlgUF24"), URLQueryItem.init(name: "q", value: searchText)]
        query?.queryItems = queryItems
        guard let queryURL = query?.url else {return}
        let urlRequest = URLRequest(url: queryURL)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let responseData = data else {
                print("error: did not receive data")
                return
            }
            do {
                guard let responseJson =  try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                    let items = responseJson["items"] as? [[String: Any]] else {
                         print("error trying to convert data to JSON")
                        return
                }
                for item in items {
                    guard let volumeInfo = item["volumeInfo"] as? [String: Any],
                        let bookTitle = volumeInfo["title"] as? String,
                        let bookAuthors = volumeInfo["authors"] as? [String],
                        let bookInfo = volumeInfo["description"] as? String
                        
                        else {
                            print("Could not get  title from JSON")
                            continue
                    }
                    let book = Book(title: bookTitle, authors: bookAuthors, info: bookInfo)
                    BooksViewController.books.append(book)
                    
                    guard let bookImageLinks = volumeInfo["imageLinks"] as? [String: Any],
                        let bookImageString = bookImageLinks["smallThumbnail"] as? String,
                        let bookImageURL = URL(string: bookImageString),
                        let data = try? Data.init(contentsOf: bookImageURL)
                        else {continue}
                    book.image = UIImage(data: data)
                    NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: nil)
                }
            } catch let exception {
                print(exception)
            }
        }
        task.resume()
    }
}
