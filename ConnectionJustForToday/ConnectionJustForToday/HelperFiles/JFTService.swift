//
//  JFTService.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import Foundation
import SwiftSoup

struct JFTService {
    
    func scrapeJFT(completion: @escaping(Result<JFTReading, NetworkError>) -> Void) {
        guard let url = URL(string: "https://www.jftna.org/jft/") else { completion(.failure(.invalidURL)); return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {completion(.failure(.noData)); return}
            do {
                if let html = String(data: data, encoding: .isoLatin1),
                   let doc = try? SwiftSoup.parse(html) {
                    let tdElements = try doc.select("body td")
                    
                    var values: [String] = []
                    for el in tdElements {
                        values.append(try el.text())
                    }
                    let keys = ["date", "title", "pageNumber", "quote", "reference", "body", "affirmation", "copyright"]
                    let result = Dictionary(uniqueKeysWithValues: zip(keys, values))
                    guard let jftReading = JFTReading(fromDictionary: result) else { return }
                    completion(.success(jftReading))
                }
            } catch {
                print(error)
                completion(.failure(.thrownError(error)))
            }
        }
        task.resume()
    }
}
