//
//  fireBaseData.swift
//  Diim
//
//  Created by Diim on 19/02/2021.
//

import Foundation

// MARK: - Services
struct Services: Decodable {
    let courses: [Course]
    let consultations: [Consultation]
    let coupons: [Coupon]
}

// MARK: - Consultation
struct Consultation: Decodable {
    let name: String
    let points: Int
    let type, id: String
}

// MARK: - Coupon
struct Coupon: Decodable {
    let name: String
    let points: Int
    let percentage, copoun: String
}

// MARK: - Course
struct Course: Decodable {
    let name: String
    let points: Int
    let verified: Bool
    let url: String
   
}
