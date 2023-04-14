//
//  BookListViewModel.swift
//  BookLibraryTestApp
//
//  Created by Evgeny on 14.04.23.
//

import Foundation
import Combine

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = true
    
    private let dataService = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    func loadData() {
        isLoading = true
        
        dataService.fetchAllBooks { [weak self] result in
            switch result {
            case .success(let response):
                self?.books = response.works
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
            
            self?.isLoading = false
        }
    }
}
