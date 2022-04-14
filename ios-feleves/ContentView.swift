//
//  ContentView.swift
//  ios-feleves
//
//  Created by Bence Papp on 2022. 03. 14..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network
    
    func getImageURL(path: Any)->String {
        if path is NSNull {
            return ""
        } else {
            return "\(path)"
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Collect your movies!")
                            .font(.subheadline)
                            .bold()
                            .padding(.leading, 10)
                            .frame(alignment: .leading)
                    }
                    
                    VStack {
                        Text("Trending now")
                            .font(.subheadline)
                            .bold()
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(network.movies) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie)){
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(getImageURL(path: movie.poster_path ?? ""))")){ image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(20)
                                    }
                                }
                                .frame(width: 140, alignment: .center)
                                .cornerRadius(15)
                            }
                        }
                        .padding(.leading, 10)
                    }
                    .padding(.vertical)
                    .frame(maxWidth:.infinity)
                    .background(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
                    .preferredColorScheme(.dark)
                    .onAppear {
                        network.getMovies(urlString: "https://api.themoviedb.org/3/movie/popular?api_key=bad9510614e88220f8ee5d44a3d0e83d&language=en-US&page=1")
                        network.getGenres()
                    }
                    
                    VStack {
                        Text("Actions")
                            .font(.subheadline)
                            .bold()
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(network.actions) { movie in
                                    HStack(alignment:.top) {
                                        
                                        NavigationLink(destination: MovieDetailView(movie: movie)){
                                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(getImageURL(path: movie.poster_path ?? ""))")){ image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .aspectRatio(contentMode: .fit)
                                        }
                                    }
                                }
                                .frame(width: 140, alignment: .center)
                                .cornerRadius(15)
                            }
                            
                        }
                        .padding(.leading, 10)
                    }
                    .padding(.vertical)
                    .frame(maxWidth:.infinity)
                    .background(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
                    .preferredColorScheme(.dark)
                    
                    VStack {
                        Text("Comedies")
                            .font(.subheadline)
                            .bold()
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(network.comedies) { movie in
                                    HStack(alignment:.top) {
                                        NavigationLink(destination: MovieDetailView(movie: movie)){
                                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(getImageURL(path: movie.poster_path ?? ""))")){ image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .aspectRatio(contentMode: .fit)
                                        }
                                    }
                                }
                                .frame(width: 140, alignment: .center)
                                .cornerRadius(15)
                            }
                            
                        }
                        .padding(.leading, 10)
                    }
                    .padding(.vertical)
                    .frame(maxWidth:.infinity)
                    .background(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
                    .preferredColorScheme(.dark)
                    
                    VStack {
                        Text("Crimes")
                            .font(.subheadline)
                            .bold()
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(network.crimes) { movie in
                                    HStack(alignment:.top) {
                                        
                                        NavigationLink(destination: MovieDetailView(movie: movie)){
                                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(getImageURL(path: movie.poster_path ?? ""))")){ image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .aspectRatio(contentMode: .fit)
                                        }
                                    }
                                }
                                .frame(width: 140, alignment: .center)
                                .cornerRadius(15)
                            }
                            
                        }
                        .padding(.leading, 10)
                    }
                    .padding(.vertical)
                    .frame(maxWidth:.infinity)
                    .background(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
                    .preferredColorScheme(.dark)
                    
                    VStack {
                        Text("Thrillers")
                            .font(.subheadline)
                            .bold()
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(network.thrillers) { movie in
                                    
                                    HStack(alignment:.top) {
                                        
                                        NavigationLink(destination: MovieDetailView(movie: movie)){
                                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(getImageURL(path: movie.poster_path ?? ""))")){ image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .aspectRatio(contentMode: .fit)
                                        }
                                    }
                                }
                                .frame(width: 140, alignment: .center)
                                .cornerRadius(15)
                            }
                            
                        }
                        .padding(.leading, 10)
                    }
                    .padding(.vertical)
                    .frame(maxWidth:.infinity)
                    .background(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
                    .preferredColorScheme(.dark)
                    
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .foregroundColor(.white)
            .background(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
            .overlay(
                HStack(spacing: 30) {
                    NavigationLink(destination: MovieCollectionView()){
                        Image(systemName: "checklist")
                    }
                    .padding()
                    .foregroundColor(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
                    .background(Color(#colorLiteral(red: 1, green: 0.7061191201, blue: 0.2282280028, alpha: 1)))
                    .cornerRadius(.infinity)
                    
                    NavigationLink(destination: MovieSearchView()){
                        Image(systemName: "magnifyingglass")
                    }
                    .padding()
                    .foregroundColor(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
                    .background(Color(#colorLiteral(red: 1, green: 0.7061191201, blue: 0.2282280028, alpha: 1)))
                    .cornerRadius(.infinity)
                }
                , alignment: .bottom)
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}
