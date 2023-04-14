//
//  BookListViewModel.swift
//  BookLibraryTestApp
//
//  Created by Evgeny on 13.04.23.
//

import Foundation
import Combine

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchBooks() {
        let url = URL(string: "https://openlibrary.org/subjects/history.json?limit=100")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BooksListResponse.self, decoder: JSONDecoder())
            .map { $0.works }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage)
                case .finished:
                    self.isLoading = false
                    print("good")
                    break
                }
            }, receiveValue: { books in
                self.books = books
            })
            .store(in: &cancellables)
    }
}
