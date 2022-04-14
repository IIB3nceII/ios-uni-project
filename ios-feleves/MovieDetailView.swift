//
//  MovieDetailView.swift
//  ios-feleves
//
//  Created by Bence Papp on 2022. 03. 15..
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var network: Network
    @State var movie: Movie
    
    public func findGenre(genId: Int)-> String {
        return network.genres.first(where: {$0.id == genId})?.name ?? "Movie"
    }
    
    func getImageURL(path: Any)->String {
        if path is NSNull {
            return ""
        } else {
            return "\(path)"
        }
    }
    
    public func addToMyList() {
        if let savedMovies = UserDefaults.standard.object(forKey: "movies") as? Data,
           var decodedMovies = try? JSONDecoder().decode([Movie].self, from: savedMovies) {
            if !decodedMovies.contains(where: {$0.id==movie.id}){
                decodedMovies.append(movie)
            let encodedMovies = try? JSONEncoder().encode(decodedMovies)
            UserDefaults.standard.set(encodedMovies, forKey: "movies")
            }
        } else {
            var storedMovies: [Movie] = []
            storedMovies.append(movie)
            let encodedMovies = try? JSONEncoder().encode(storedMovies)
            UserDefaults.standard.set(encodedMovies, forKey: "movies")
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(getImageURL(path: movie.poster_path ?? ""))")){ image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .frame(width: 200, alignment: .center)
                    
                    VStack(spacing: 15) {
                        VStack(spacing: 5) {
                            Image(systemName: "video.fill")
                            
                            Text("Genre")
                                .foregroundColor(Color(#colorLiteral(red: 0.4992976189, green: 0.4992976189, blue: 0.5109832883, alpha: 1)))
                            
                            Text("\(findGenre(genId:movie.genre_ids.count>0 ? movie.genre_ids[0] : 1))")
                                .bold()
                        }
                        .padding(.horizontal,30)
                        .padding(.vertical, 10)
                        .frame(width: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(#colorLiteral(red: 0.2282280028, green: 0.2282280028, blue: 0.2684496939, alpha: 1)), lineWidth: 1)
                        )
                        
                        VStack(spacing: 5) {
                            Image(systemName: "play.fill")
                            
                            Text("Release")
                                .foregroundColor(Color(#colorLiteral(red: 0.4992976189, green: 0.4992976189, blue: 0.5109832883, alpha: 1)))
                            
                            Text("\(movie.release_date)")
                                .bold()
                        }
                        .padding(.horizontal,30)
                        .padding(.vertical, 10)
                        .frame(width: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(#colorLiteral(red: 0.2282280028, green: 0.2282280028, blue: 0.2684496939, alpha: 1)), lineWidth: 1)
                        )
                        
                        VStack(spacing: 5) {
                            Image(systemName: "star.fill")
                            
                            Text("Rating")
                                .foregroundColor(Color(#colorLiteral(red: 0.4992976189, green: 0.4992976189, blue: 0.5109832883, alpha: 1)))
                            
                            Text("\(String(format: "%.1f", movie.vote_average))/10")
                                .bold()
                        }
                        .padding(.horizontal,30)
                        .padding(.vertical, 10)
                        .frame(width: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(#colorLiteral(red: 0.2282280028, green: 0.2282280028, blue: 0.2684496939, alpha: 1)), lineWidth: 1)
                        )
                    }
                    .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .top)
                }
                .frame(maxWidth: .infinity, maxHeight: 300, alignment: .topLeading)
                
                Text("\(movie.title)")
                    .font(.title)
                    .bold()
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0.1866790652, green: 0.1866790652, blue: 0.2282280028, alpha: 1)))
                
                Text("\(movie.overview)")
                    .padding(.vertical, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .foregroundColor(.white)
        .background(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
        .overlay(
            VStack {
                Button(action: addToMyList) {
                    Text("Add to my list")
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .foregroundColor(Color(#colorLiteral(red: 0.109802641, green: 0.1098048761, blue: 0.1523296535, alpha: 1)))
                        .background(Color(#colorLiteral(red: 1, green: 0.7061191201, blue: 0.2282280028, alpha: 1)))
                        .cornerRadius(30)
                }
            }
                .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
                .background(Color(#colorLiteral(red: 0.1079614237, green: 0.1094036177, blue: 0.1507558227, alpha: 1)))
                .shadow(color: Color(#colorLiteral(red: 0.1079614237, green: 0.1094036177, blue: 0.1507558227, alpha: 1)), radius: 20, x: 0, y: -30)
            , alignment: .bottom)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    let movie: Movie
    
    static var previews: some View {
        MovieDetailView(movie: Movie(id: 1,
                                     adult: false,
                                     backdrop_path: "String",
                                     genre_ids: [1],
                                     original_language: "String",
                                     original_title: "String",
                                     overview: "Apple pie croissant lemon drops shortbread lollipop chocolate. Pudding cake caramels chocolate bar topping cake cookie. Apple pie brownie jelly ice cream liquorice cupcake carrot cake. Pastry marshmallow chocolate cake chocolate muffin. Sweet roll jelly beans fruitcake donut muffin pudding bear claw bear claw. Biscuit chupa chups lemon drops toffee sweet pastry bonbon dragée. Tiramisu jujubes cheesecake jelly tootsie roll sugar plum cupcake. Ice cream dessert sesame snaps caramels shortbread fruitcake cake. Pie pie tiramisu ice cream sugar plum danish gummies topping tiramisu. Tart jelly beans sugar plum marzipan liquorice cheesecake. Tart tootsie roll dessert chocolate caramels. Oat cake pudding oat cake cookie soufflé toffee liquorice gummies.",
                                     popularity: 1.0,
                                     poster_path: "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
                                     release_date: "2021-03-24",
                                     title: "String",
                                     video: false,
                                     vote_average: 1.0,
                                     vote_count: 1))
            .environmentObject(Network())
    }
}
