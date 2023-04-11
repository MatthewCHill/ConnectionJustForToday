//
//  FirebaseService.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation
import FirebaseFirestore

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

struct FirebaseService {
    
    let ref = Firestore.firestore()
    
    func createJFTPost(post: String, isControversial: Bool) {
        
        let post = JFTPost(post: post, isControversial: isControversial)
        ref.collection(JFTPost.Key.collectionType).document(post.uuid).setData(post.dictionaryRepresentation)
    }
    
    func loadJFTPost(completion: @escaping (Result<[JFTPost], FirebaseError>) -> Void) {
        ref.collection(JFTPost.Key.collectionType).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let data = snapshot?.documents else {
                completion(.failure(.noDataFound))
                return
            }
            
            let dictionaryArray = data.compactMap { $0.data() }
            let posts = dictionaryArray.compactMap { JFTPost(fromDictionary: $0)}
            completion(.success(posts))
        }
    }
    
    func createSPADPost(post: String, isControversial: Bool) {
        let post = SPADPost(post: post, isControversial: isControversial)
        ref.collection(SPADPost.Key.collectionType).document(post.uuid).setData(post.dictionaryRepresentation)
    }
    
    
    func loadSPADPost(completion: @escaping (Result<[SPADPost], FirebaseError>) -> Void) {
        ref.collection(SPADPost.Key.collectionType).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let data = snapshot?.documents else {
                completion(.failure(.noDataFound))
                return
            }
            
            let dictionaryArray = data.compactMap { $0.data() }
            let posts = dictionaryArray.compactMap { SPADPost(fromDictionary: $0)}
            completion(.success(posts))
        }
    }
} // End of class
