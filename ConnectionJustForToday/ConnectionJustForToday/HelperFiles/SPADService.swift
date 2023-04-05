//
//  SPADService.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/5/23.
//

import Foundation
import SwiftSoup

struct SPADService {
    
    func scrapeSPAD(completion: @escaping (Result<SPADReading, NetworkError>) -> Void) {
        guard let url = URL(string: "https://pensacolana.org/spad/") else { completion(.failure(.invalidURL)); return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { completion(.failure(.noData)); return}
            do {
                if let html = String(data: data, encoding: .utf8),
                   let doc = try? SwiftSoup.parse(html) {
                    let elements = try doc.select(".spad-rendered-element div")
                    
                    var values = [String]()
                    for el in elements {
                        if el.id() == "spad-divider" {
                            continue
                        } else {
                            values.append(try el.text())
                        }
                    }
                    
                    let keys = ["date", "title", "pageNumber", "quote", "reference", "body", "affirmation", "copyright"]
                    let result = Dictionary(uniqueKeysWithValues: zip(keys, values))
                    guard let spadReading = SPADReading(fromDictionary: result) else { completion(.failure(.unableToDecode)); return}
                    completion(.success(spadReading))
                    
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
        }
    }
}
