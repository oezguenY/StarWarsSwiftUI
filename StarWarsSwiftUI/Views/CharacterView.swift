//
//  PersonView.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import SwiftUI

struct CharactersView: View {
    private static var navigationTitle = NSLocalizedString("charactersNavigationTitle", comment: "")
    @ObservedObject var viewModel: CharactersViewModel
    @State private var searchTerm: String
    @State private var error: Error?
    @State private var shouldShowAlert: Bool = false
    
    private var filteredCharacters: [Character] {
        guard !searchTerm.isEmpty else { return viewModel.charactersFromCurrentPage }
        return viewModel.allCharacters.filter { $0.name.localizedStandardContains(searchTerm) }
    }
    
    init(viewModel: CharactersViewModel) {
        NavigationBarConfiguration.configureTitle()
        self.searchTerm = ""
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                mainView
                    .navigationTitle(Self.navigationTitle)
                    .background {
                        SpaceBackgroundView()
                    }
            }
            .task {
                do {
                    try await viewModel.fetchCharacters()
                } catch {
                    self.error = error
                    shouldShowAlert = true
                }
                
            }
            .alert(isPresented: $shouldShowAlert,
                   content: {
                if let error = error {
                    CustomSystemAlert().alertFromError(error, shouldShowAlert: $shouldShowAlert)
                } else {
                    Alert(title: Text(""))
                }
            })
            if !viewModel.charactersFetchingFinished {
                LoadingView()
            }
        }
    }
    
    @ViewBuilder
    private var mainView: some View {
        VStack {
            charactersListView()
                .frame(maxHeight: .infinity)
            numberedPageControlsView()
                .frame(maxHeight: 64)
        }
    }
    
    private func charactersListView() -> some View {
        List(filteredCharacters, id: \.name) { character in
            NavigationLink {
                CharacterDetailedView(character: character,
                                      charactersViewModel: viewModel)
            } label: {
                CustomCellView(character: character,
                               charactersViewModel: viewModel)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(CustomColor.clear)
            .listRowInsets(EdgeInsets())
        }
        .scrollContentBackground(.hidden)
        .listRowSpacing(8)
        .searchable(text: $searchTerm, prompt: NSLocalizedString("charactersSearchBar", comment: ""))
        .font(CustomTypography.body)
        .foregroundColor(CustomColor.white)
    }
    
    private func numberedPageControlsView() -> some View {
        HStack {
            ChangePageButtonView(pointingDirection: .left,
                                 isDisabled: viewModel.isFirstPage()) {
                viewModel.currentPage -= 1
            }
                                 .padding(.leading, 16)
            Text("\(viewModel.currentPage)")
                .bodyStyle()
                .padding(.horizontal, 64)
            ChangePageButtonView(pointingDirection: .right,
                                 isDisabled: viewModel.isLastPage()) {
                viewModel.currentPage += 1
            }
                                 .padding(.trailing, 16)
        }
    }
}
