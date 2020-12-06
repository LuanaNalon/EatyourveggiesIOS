//
//  VagetableRepository.swift
//  LoginSpike
//
//  Created by Mac on 06/12/2020.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class VegetableRepository: ObservableObject{
    let db = Firestore.firestore()
    
    @Published var vegetables = [Vegetable]()
    
    func loadData() {
        db.collection("vegetables").addSnapshotListener{
            (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.vegetables =  querySnapshot.documents.compactMap { document in
                   try? document.data(as: Vegetable.self)
                }
            }
        }
    }
}
