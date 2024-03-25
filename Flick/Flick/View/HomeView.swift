//
//  ContentView.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel: HomeViewViewModel

    var body: some View {
        VStack {
            TextField("Search...", text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) {
                    viewModel.fetchThumbs()
                }
            List(viewModel.thumbs, id: \.id) { thumb in
                AsyncImage(url: URL(string: thumb.media.m))
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView(
        viewModel: HomeViewViewModel(
            client: FlickService(client: URLSession.shared)
        )
    )
}
