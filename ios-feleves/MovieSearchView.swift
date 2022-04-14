//
//  MovieSearchView.swift
//  ios-feleves
//
//  Created by Bence Papp on 2022. 03. 17..
//

import SwiftUI

struct MovieSearchView: View {
    @EnvironmentObject var network: Network
    @State private var searchText: String = ""
    @State private var searchResults: [Movie] = []
    
    public func searchMovie() {
        let split = searchText.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ").map(String.init)
        let normalizedQueryString = split.joined(separator: "")
        if searchText.count > 3 {
            guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=bad9510614e88220f8ee5d44a3d0e83d&language=en-US&query=\(normalizedQueryString)&page=1") else { fatalError("Missing URL") }
            
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
                            
                            self.searchResults = decodedMovies.results
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    var body: some View {
        List {
            ForEach(results)  { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)){
                    Text(movie.title)
                }
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Search")
        .background(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
        .onChange(of: searchText) {value in searchMovie()}
    }
    
    var results: [Movie] {
        if searchText.count > 3 {
            return searchResults
        } else {
            return network.movies
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView().environmentObject(Network())
    }
}
