//
//  PersonCellView.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import SwiftUI

struct CustomCellView: View {
    @State private var avatarRotationDegrees: Double
    @State private var characterImage: Image?
    private let character: Character
    private let charactersViewModel: CharactersViewModel
    
    init(character: Character,
         charactersViewModel: CharactersViewModel) {
        avatarRotationDegrees = 0.0
        self.character = character
        self.charactersViewModel = charactersViewModel
    }
    
    var body: some View {
        mainView
            .onAppear {
                startAvatarRotation()
                Task {
                    do {
                        if let imageUrl = await charactersViewModel.fetchCharacterImageUrl(character) {
                            let (data, _) = try await URLSession.shared.data(from: imageUrl)
                            if let characterUiImage = UIImage(data: data) {
                                characterImage = Image(uiImage: characterUiImage)
                            }
                        }
                    } catch {
                        print("Error fetching character image: \(error)")
                    }
                }
            }
    }
    
    private var mainView: some View {
        ZStack {
            CustomColor.darkerGray
            HStack {
                characterAvatarView()
                    .padding(.vertical, 8)
                Spacer()
                titleView()
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder
    private func characterAvatarView() -> some View {
        let avatarImage = characterImage ?? CustomImaging.questionMark
        avatarImage
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(avatarRotationDegrees), axis: (x: 0, y: 1, z: 0))
    }
    
    private func titleView() -> some View {
        Text(character.name)
            .bodyStyle()
            .lineLimit(1)
            .minimumScaleFactor(0.8)
    }
    
    private func startAvatarRotation() {
        withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
            avatarRotationDegrees = 360
        }
    }
}

