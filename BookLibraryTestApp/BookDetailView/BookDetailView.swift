//
// BookDetailView.swift
// BookLibraryTestApp
//
// Created by Evgeny on 14.04.23.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject var viewModel: BookDetailViewModel
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
            Text("Loading Data from Server")
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
        } else {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    Text(viewModel.bookTitle)
                        .font(.title)
                    
                    coverImage
                    
                    if let authors = viewModel.bookAuthors {
                        Text("Author(s): " + authors.map { $0.name }.joined(separator: ", "))
                            .foregroundColor(.secondary)
                    }
                    
                    Text("First Publish Date: \(viewModel.bookFirstPublishDate)")
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.bookDescripsion)
                        .padding(.bottom, 16)
                }
                .padding()
            }
            .navigationBarTitle(Text("Book Detail"), displayMode: .inline)
        }
    }
    
    var coverImage: some View {
        Group {
            if let coverId = viewModel.bookImageUrl {
                let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg")!
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray)
                }
                .frame(width: 100, height: 140)
                .cornerRadius(5)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 140)
                    .cornerRadius(5)
            }
        }
    }
}
