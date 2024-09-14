//
//  PersonDetailView.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import SwiftUI

struct CharacterDetailedView: View {
    @State private var bouncing = false
    @State private var characterImage: Image?
    private var character: Character
    private let charactersViewModel: CharactersViewModel
    
    init(character: Character,
         charactersViewModel: CharactersViewModel) {
        self.character = character
        self.charactersViewModel = charactersViewModel
    }
    
    var body: some View {
        mainView
            .background {
                SpaceBackgroundView()
            }
            .onAppear {
                Task {
                    do {
                        if let imageUrl = await charactersViewModel.fetchCharacterImageUrl(character) {
                            let (data, _) = try await URLSession.shared.data(from: imageUrl)
                            if let characterUiImage = UIImage(data: data) {
                                characterImage = Image(uiImage: characterUiImage)
                            }
                        }
                    } catch {
                        print("Fetching character image for \(character.name) failed with error: \(error)")
                    }
                }
            }
    }
    
    private var mainView: some View {
        VStack {
            characterAvatarView()
                .padding([.top, .bottom], 32)
            characterNameView()
                .padding(.bottom, 8)
            characterInfoView()
                .padding(.bottom, 32)
        }
        .padding(.horizontal, 32)
    }
    
    private func characterNameView() -> some View {
        Text(character.name)
            .h1Style()
    }
    
    private func characterInfoView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if character.gender != .other {
                HStack {
                    Text(localizedStringKey: "characterDetailedGender")
                        .bodyStyle()
                        .padding(.leading, -3)
                    genderImageView(character.gender)
                }
            }
            Text(localizedStringKey: "characterDetailedBirth", argument: "\(character.birthYear)")
                .bodyStyle()
            Text(localizedStringKey: "characterDetailedHeight", argument: "\(character.height)")
                .bodyStyle()
            Text(localizedStringKey: "characterDetailedWeight", argument: "\(character.weight)")
                .bodyStyle()
            Text(localizedStringKey: "characterDetailedHair", argument: "\(character.hairColor)")
                .bodyStyle()
            Text(localizedStringKey: "characterDetailedSkin", argument: "\(character.skinColor)")
                .bodyStyle()
            Text(localizedStringKey: "characterDetailedEyes", argument: "\(character.eyesColor)")
                .bodyStyle()
        }
    }
    
    @ViewBuilder
    private func characterAvatarView() -> some View {
        let avatarImage = characterImage ?? CustomImaging.questionMark
        avatarImage
            .resizable()
            .background(Color.white)
            .aspectRatio(contentMode: .fill)
            .frame(width: 256, height: 256)
            .clipShape(Circle())
            .frame(maxHeight: 280, alignment: bouncing ? .bottom : .top)
            .animation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true),
                       value: bouncing)
            .onAppear {
                self.bouncing = false
                self.bouncing.toggle()
            }
    }
    
    @ViewBuilder
    private func genderImageView(_ gender: Gender) -> some View {
        let frameSize: CGFloat = 24
        
        switch gender {
        case .male:
            CustomImaging.genderMale
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(CustomColor.white)
                .frame(width: frameSize, height: frameSize)
        case .female:
            CustomImaging.genderFemale
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(CustomColor.white)
                .frame(width: frameSize, height: frameSize)
        default:
            EmptyView()
        }
    }
}
