//
// BookListView.swift
// BookLibraryTestApp
//
// Created by Evgeny on 13.04.23.
//

import SwiftUI
import Combine

struct BookListView: View {
    @ObservedObject var viewModel = BookListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.isLoading {
                    listBodyView
                } else {
                    ProgressView()
                    Text("Loading Data")
                }
            }
        }
        .onAppear {
            viewModel.fetchBooks()
        }
    }
    
    var listBodyView: some View {
        List(viewModel.books, id: \.key) { book in
            NavigationLink(destination: BookDetailView(viewModel: BookDetailViewModel(bookImageUrl: book.cover_id ?? 0, bookFirstPublishDate: book.firstPublishYear ?? 0, bookKey: book.key, bookAuthors: book.authors!))) {
                BookRowView(book: book)
            }
        }
        .navigationTitle("History books")
        .listStyle(PlainListStyle())
    }
}

struct BookRowView: View {
    let book: Book
    
    var body: some View {
        HStack {
            coverImage
            VStack(alignment: .leading, spacing: 5) {
                Text(book.title)
                    .font(.headline)
                
                Text("First Publish Year: ")
                    .font(.subheadline)
                    .foregroundColor(.gray) +
                Text(String(book.firstPublishYear ?? 0))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
    
    var coverImage: some View {
        Group {
            if let coverId = book.cover_id {
                let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg")!
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray)
                }
                .frame(width: 50, height: 70)
                .cornerRadius(5)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 70)
                    .cornerRadius(5)
            }
        }
    }
}


struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
