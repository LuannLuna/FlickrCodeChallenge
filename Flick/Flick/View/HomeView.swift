//
//  ContentView.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel: HomeViewViewModel

    var body: some View {
        VStack {
            TextField("Search...", text: $viewModel.searchText)
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
