//
//  ContentView.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import SwiftUI

struct HomeView: View {
    
    private
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @ObservedObject var viewModel: HomeViewViewModel

    var body: some View {
        VStack {
            TextField("Search...", text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) {
                    viewModel.fetchThumbs()
                }
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.thumbs, id: \.id) { thumb in
                        AsyncImage(url: URL(string: thumb.media.m))
                            .scaledToFit()
                            .frame(width: 150)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
        #if DEBUG
        .onAppear {
            viewModel.fetchThumbs()
        }
        #endif
    }
}

#Preview {
    HomeView(
        viewModel: HomeViewViewModel(
            searchText: "Star",
            client: FlickService(client: URLSession.shared)
        )
    )
}
