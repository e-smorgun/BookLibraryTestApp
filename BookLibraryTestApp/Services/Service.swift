//
//  Service.swift
//  BookLibraryTestApp
//
//  Created by Evgeny on 13.04.23.
//

import Foundation

class DataService {
    private func fetchModel<T: Decodable>(from url: URL, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(data)
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                print(result)
                completion(result)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    func fetchBookDetail(urlKey: String, completion: @escaping (BookDetail?) -> Void) {
        let url = URL(string: "https://openlibrary.org/works/OL99499W.json")!
        fetchModel(from: url, completion: completion)
    }
}
