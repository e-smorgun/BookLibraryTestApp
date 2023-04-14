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
    
    // MARK: Methods
    func loadData() {
        dataService.fetchBookDetail(urlKey: bookKey, completion: { [weak self] item in
            //print(item?.title)
            self?.bookDescripsion = item?.description ?? ""
            self?.bookTitle = item?.title ?? ""
        })
    }
}
