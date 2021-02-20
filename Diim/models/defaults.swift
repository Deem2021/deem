//
//  defaults.swift
//  Diim
//
//  Created by Diim on 18/02/2021.
//

import Foundation

struct Defaults {
    
    static let isUserLoged = "isUserLog"
    static let userId = "userID"
    static let username = "userName"
    static let points = "points"


    static func save(userID:String,userName:String){
        UserDefaults.standard.set(userID, forKey: userId)
        UserDefaults.standard.set(userName, forKey: username)
        UserDefaults.standard.set(true, forKey: isUserLoged)
    }
    static func savePoints(points:String){
        UserDefaults.standard.set(points, forKey: points)
    }
  
    static func getUserID()-> String {
        if let userId = UserDefaults.standard.value(forKey: userId) {
            return userId as! String
        }
        else {
            return ""
        }
    }


    static func isUserLogedIn()-> Bool {
        return UserDefaults.standard.bool(forKey: isUserLoged)
    }
 
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userId)
        UserDefaults.standard.removeObject(forKey: username)
        UserDefaults.standard.set(false, forKey: isUserLoged)
    }
}
