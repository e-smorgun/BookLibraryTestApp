//
//  Service.swift
//  BookLibraryTestApp
//
//  Created by Evgeny on 13.04.23.
//

import Foundation

class DataService {
    private func fetchModel<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data is nil", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchAllBooks(theme: String = "history", completion: @escaping (Result<BooksListResponse, Error>) -> Void) {
        let url = URL(string: "https://openlibrary.org/subjects/\(theme).json?limit=100")!
        fetchModel(from: url, completion: completion)
    }
    
    func fetchBookDetail(urlKey: String, completion: @escaping (Result<BookDetail, Error>) -> Void) {
        print("https://openlibrary.org/works/\(urlKey).json")
        let url = URL(string: "https://openlibrary.org\(urlKey).json")!
        fetchModel(from: url, completion: completion)
    }
}
