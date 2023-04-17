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
    
    // MARK: - JFT Functions
    func createJFTPost(post: String, displayName: String, country: String, isControversial: Bool) {
        
        let post = JFTPost(post: post, displayName: displayName, country: country, isControversial: isControversial)
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
    
    func deleteJFTPost(post: JFTPost) {
        ref.collection(JFTPost.Key.collectionType).document(post.uuid).delete()
    }
    
    // MARK: - SPAD Functions
    func createSPADPost(post: String, displayName: String, country: String,isControversial: Bool) {
        let post = SPADPost(post: post, displayName: displayName, country: country, isControversial: isControversial)
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
    
    func deleteSPADPost(post: SPADPost) {
        ref.collection(SPADPost.Key.collectionType).document(post.uuid).delete()
    }
    
    // MARK: - User functions
    func saveUserSetting(userName: String, cleanDate: String, country: String) {
        let user = User(name: userName, cleanDate: cleanDate, country: country)
        ref.collection(User.Key.collectionType).document(user.uuid).setData(user.dictionaryRepresentation)
    }
    
    func fetchUserInfo(completion: @escaping(Result<User, FirebaseError>) -> Void) {
        ref.collection(User.Key.collectionType).getDocuments { snapshot, error in
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
            let users = dictionaryArray.compactMap { User(fromDictionary: $0)}
            guard let user = users.first else {return}
            completion(.success(user))
        }
    }
    
} // End of class
