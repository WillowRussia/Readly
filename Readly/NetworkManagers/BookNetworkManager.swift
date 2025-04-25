//
//  BookNetworkManager.swift
//  Readly
//
//  Created by Илья Востров on 20.04.2025.
//
import Foundation

class BookNetworkManager {
    
    let url = "https://openlibrary.org/search.json"
    static let shared = BookNetworkManager()
    
    private init(){}
    
    func serachBookRequest(q: String, completion: @escaping (Swift.Result<[JsonBookModelItem], Error>) -> Void){
        var urlComponent = URLComponents(string: url)
        urlComponent?.queryItems = [
            URLQueryItem (name: "q", value: q),
            URLQueryItem(name: "fields", value:
                            "title,author_name,cover_i,subtitle,number_of_pages_median,first_publish_year,ratings_count"),
            URLQueryItem (name: "lang", value: "ru")
        ]
        
        guard let url = urlComponent?.url else { return }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(.failure(error!))
                return
            }
            
            guard let data else { return }
            
            do {
                let books = try JSONDecoder().decode(JsonBookModel.self, from: data)
                completion(.success(books.docs))
            }
            catch {
                print((error.localizedDescription))
                completion(.failure(error))
            }
        }.resume()
       
    }
}
