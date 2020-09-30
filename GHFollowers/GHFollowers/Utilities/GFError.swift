//
//  GFError.swift
//  GHFollowers
//
//  Created by Apple on 9/14/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUserName = "This userName created an invalid request. please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. please try again."
    case invalidData = "The data received from the server was invalid. Please try again"
    case unableToFavorites = "There was an eror favorites this user. Please try again"
    case alreadyInFavorites = "You've already favorited this user, You must REALLY like them!"
}
