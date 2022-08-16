//
//  EpisodeListView.swift
//  RickAndMorty
//
//  Created by Ondrej Steiner on 11.08.2022.
//  Copyright © 2022 STRV. All rights reserved.
//

import SwiftUI

struct EpisodeListView: View {
    
    
    var body: some View {
        
        
        ZStack {
            
            BackgroundGradientView()
            listView
            
//            List() {
//                ForEach(Episode.episodes, id: \.self) { episode in
//                    EpisodeListItemView(episode: .mock)
//
//
//                }
                .navigationTitle(R.string.localizable.tabTitleEpisodes())
//
//
//            }
        }
        
    }
}

struct EpisodeListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListView()
            
    }
}


@ViewBuilder var listView: some View {
    ScrollView {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(Episode.episodes, id: \.self) { episodes in
                EpisodeListItemView(episode: .mock)
            }
        }
        .padding(.horizontal, 16)
        .transition(.fade)
    }
}
