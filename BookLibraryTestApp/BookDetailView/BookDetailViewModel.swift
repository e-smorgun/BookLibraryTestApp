//
//  BookDetailViewModel.swift
//  BookLibraryTestApp
//
//  Created by Evgeny on 13.04.23.
//

import Foundation
import SwiftUI

class BookDetailViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let bookKey: String
    @Published var bookAuthors: [Author] = []
    @Published var bookDescripsion: String = ""
    @Published var bookFirstPublishDate: Int = 0
    @Published var bookTitle: String = ""
    @Published var bookImageUrl: Int = 0
    
    private let dataService = DataService()

    init(bookImageUrl: Int, bookFirstPublishDate: Int, bookKey: String, bookAuthors: [Author]) {
        self.bookAuthors = bookAuthors
        self.bookKey = bookKey
        self.bookFirstPublishDate = bookFirstPublishDate
        self.bookImageUrl = bookImageUrl
        
        loadData()
    }
    
    func loadData() {
        isLoading = true
        
        dataService.fetchBookDetail(urlKey: bookKey, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.bookDescripsion = response.description
                self?.bookTitle = response.title
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
            
            self?.isLoading = false
        })
    }
}
