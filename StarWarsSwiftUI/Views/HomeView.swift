//
//  HomeView.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import SwiftUI

struct HomeView: View {
    @State var charactersViewModel: CharactersViewModel
    @State private var showCharacters: Bool = false
    
    init() {
        NavigationBarConfiguration.configureTitle()
        charactersViewModel = CharactersViewModel()
    }
    
    var body: some View {
        if !showCharacters {
            mainView
                .background {
                    SpaceBackgroundView()
                }
        } else {
            CharactersView(viewModel: charactersViewModel)
        }
    }
    
    private var mainView: some View {
        VStack {
            titleView()
                .padding(.top, 128)
                .padding(.bottom, 64)
            Spacer()
            startButtonView()
                .padding(.bottom, 64)
        }
    }
    
    private func titleView() -> some View {
        VStack {
            Text(NSLocalizedString("homeStarWarsTitle", comment: ""))
                .titleStyle()
                .padding(.bottom, 16)
            Text(NSLocalizedString("homeSubtitle", comment: ""))
                .subtitleStyle()
        }
        .padding(.horizontal, 16)
    }
    
    private func startButtonView() -> some View {
        Button {
            showCharacters.toggle()
        } label: {
            ZStack {
                Circle()
                    .fill(CustomColor.starWarsYellow.opacity(0.8))
                    .frame(width: 128)
                    .shadow(color: CustomColor.starWarsYellow,
                            radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Text(NSLocalizedString("homeStartButton", comment: ""))
                    .customStyleWithSize(color: CustomColor.black,
                                         size: 24)
            }
        }
    }
}

#Preview {
    HomeView()
}
