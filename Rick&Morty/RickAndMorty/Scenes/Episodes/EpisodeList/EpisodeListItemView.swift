//
//  EpisodeListItemView.swift
//  RickAndMorty
//
//  Created by Ondrej Steiner on 11.08.2022.
//  Copyright © 2022 STRV. All rights reserved.
//

import SwiftUI

struct EpisodeListItemView: View {
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading) {
        
            Text("\(episode.name)")
                .font(.appItemLargeTitle)
                .foregroundColor(.appTextItemTitle)
                .multilineTextAlignment(.leading)
            
            
            Text("\(episode.code) + \(episode.airDate)")
                .font(.appItemDescription)
                .foregroundColor(.appTextBody)
                
            
        }
    }
}


struct EpisodeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListItemView(episode: .mock)
            
    }
}
