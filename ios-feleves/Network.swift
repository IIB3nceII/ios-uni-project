//
//  Network.swift
//  ios-feleves
//
//  Created by Bence Papp on 2022. 03. 14..
//

import SwiftUI

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct GenreResponse: Decodable {
    let genres: [Genre]
}

class Network: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var actions: [Movie] = []
    @Published var comedies: [Movie] = []
    @Published var crimes: [Movie] = []
    @Published var thrillers: [Movie] = []
    
    @Published var genres: [Genre] = []
    
    func getMovies(urlString: String) {
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedMovies = try JSONDecoder().decode(networkResponse.self, from: data)
                        self.movies = decodedMovies.results
                        
                        self.actions = decodedMovies.results.filter { movie in
                            return movie.genre_ids.contains(28)
                        }
                        
                        self.comedies = decodedMovies.results.filter { movie in
                            return movie.genre_ids.contains(35)
                        }
                        
                        self.crimes = decodedMovies.results.filter { movie in
                            return movie.genre_ids.contains(80)
                        }
                        
                        self.thrillers = decodedMovies.results.filter { movie in
                            return movie.genre_ids.contains(53)
                        }
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    func getGenres() {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=bad9510614e88220f8ee5d44a3d0e83d&language=en-US") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(GenreResponse.self, from: data)
                        self.genres = decoded.genres
                        
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
