//
//  User.swift
//  ios-feleves
//
//  Created by Bence Papp on 2022. 03. 14..
//

import Foundation

struct networkResponse: Decodable, Encodable {
    let page: Int
    let results: Array<Movie>
    let total_pages: Int
    let total_results: Int
}

struct Movie: Identifiable, Decodable, Encodable, Equatable {
    let id: Int
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: Array<Int>
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    var poster_path: String?
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
}
