//
//  MovieCollectionView.swift
//  ios-feleves
//
//  Created by Bence Papp on 2022. 03. 18..
//

import SwiftUI

struct MovieCollectionView: View {
    @State var movies: [Movie] = []
    
    func getMovies() {
        if let savedMovies = UserDefaults.standard.object(forKey: "movies") as? Data,
           let decodedMovies = try? JSONDecoder().decode([Movie].self, from: savedMovies) {
            self.movies = decodedMovies
            print(movies)
        } else {
            self.movies = []
            print(movies)
        }
    }
    
    func removeMovie(id: Int) {
        if let savedMovies = UserDefaults.standard.object(forKey: "movies") as? Data,
           var decodedMovies = try? JSONDecoder().decode([Movie].self, from: savedMovies) {
            
            let idx = decodedMovies.firstIndex(where: {$0.id == id})
            
            if (idx != nil) {
                decodedMovies.remove(at: idx!)
                let encodedMovies = try? JSONEncoder().encode(decodedMovies)
                UserDefaults.standard.set(encodedMovies, forKey: "movies")
                self.movies = decodedMovies
            }
        }
    }
    
    func getImageURL(path: Any)->String {
        if path is NSNull {
            return ""
        } else {
            return "\(path)"
        }
    }
    
    var body: some View {
        ScrollView {
            if (movies.isEmpty) {
                Text("Go back and add your movies!")
            } else {
                VStack(spacing: 5) {
                    Text("\(movies.count) movie in your collection")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if (movies.count > 20) {
                        Text("Bro, you are a beast! 🤯")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                }
                
                
                ForEach(movies) { movie in
                    HStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(getImageURL(path: movie.poster_path ?? ""))")){ image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(movie.title)
                                .bold()
                            Text("\(String(format: "%.1f", movie.vote_average))/10")
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "heart.slash.fill")
                            .padding()
                            .foregroundColor(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
                            .background(Color(#colorLiteral(red: 1, green: 0.7061191201, blue: 0.2282280028, alpha: 1)))
                            .cornerRadius(.infinity)
                            .onTapGesture {
                                removeMovie(id: movie.id)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.193584287, green: 0.1951218109, blue: 0.2630145056, alpha: 1)))
                    .cornerRadius(20)
                    .animation(Animation.easeInOut(duration: 0.5), value: movies)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color(#colorLiteral(red: 0.1079614237, green: 0.1094036177, blue: 0.1507558227, alpha: 1)))
        .onAppear {
            getMovies()
        }
        
    }
}

struct MovieCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCollectionView()
    }
}
