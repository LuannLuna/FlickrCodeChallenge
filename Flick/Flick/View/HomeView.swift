//
//  ContentView.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import SwiftUI

struct HomeView: View {
    enum Layout: CaseIterable {
        case one
        case two
        case three

        var image: Image {
            let systemName = switch self {
            case .one:
                "rectangle.grid.2x2"

            case .two:
                "rectangle.grid.3x2"

            case .three:
                "rectangle.grid.1x2"
            }
            return Image(systemName: systemName)
        }

        mutating
        func goNext() {
            switch self {
                case .one:
                    self = .two
                case .two:
                    self = .three
                case .three:
                    self = .one
            }
        }
    }

    @State var layout: Layout = .three
    @ObservedObject var viewModel: HomeViewViewModel

    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $viewModel.searchText)
                    .onChange(of: viewModel.searchText) {
                        viewModel.fetchThumbs()
                    }

                Button {
                    layout.goNext()
                } label: {
                    layout.image
                }
            }

            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.thumbs, id: \.id) { thumb in
                        AsyncImage(url: thumb.url)
                            .scaledToFit()
                            .frame(width: width, alignment: .center)
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

private
extension HomeView {
    var columns: [GridItem]  {
        switch layout {
            case .one:
                return [GridItem(.flexible())]
            case .two:
                return [GridItem(.flexible()), GridItem(.flexible())]
            case .three:
                return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        }
    }

    var width: CGFloat {
        switch layout {
            case .one:
                200
            case .two:
                150
            case .three:
                100
        }
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
