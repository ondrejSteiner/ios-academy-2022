//
//  CharactersCoordinator.swift
//  RickAndMorty
//
//  Created by Jan Schwarz on 13.05.2022.
//  Copyright © 2022 STRV. All rights reserved.
//

import DependencyInjection
import SwiftUI
import UIKit

final class CharactersCoordinator {
    let container: Container
    var childCoordinators: [Coordinator] = []

    lazy var navigationController: UINavigationController = RMNavigationController()

    init(container: Container) {
        self.container = container
    }
}

// MARK: - Coordinator lifecycle
extension CharactersCoordinator: NavigationControllerCoordinator {
    func start() {
        navigationController.setViewControllers([makeCharactersList()], animated: false)
    }
}

// MARK: - Factories
extension CharactersCoordinator {
    func makeCharactersList() -> UIViewController {
        let store = container.resolve(type: CharactersListStore.self)
        let charactersList = CharactersListView(store: store, coordinator: self)

        return UIHostingController(rootView: charactersList)
    }

    func makeCharacterDetail(for character: Character) -> UIViewController {
        let store = container.resolve(type: CharacterDetailStore.self, argument: character)
        let characterDetail = CharacterDetailView(store: store, coordinator: self)

        return UIHostingController(rootView: characterDetail)
    }

    func makeEpisodeDetail(for episode: Episode) -> UIViewController {
        let store = container.resolve(type: EpisodeDetailStore.self, argument: episode)
        let episodeDetail = EpisodeDetailView(store: store, coordinator: self)

        return UIHostingController(rootView: episodeDetail)
    }

    func makeLocationDetail(with id: Int) -> UIViewController {
        // swiftlint:disable:next force_unwrapping
        let viewController = R.storyboard.locationDetailViewController.instantiateInitialViewController()!
        let store = container.resolve(type: LocationDetailStore.self, argument: id)

        viewController.store = store
        viewController.coordinator = self

        return viewController
    }

    func makeWebView(for url: URL) -> UIViewController {
        let webView = WebView(url: url)

        return UIHostingController(rootView: webView)
    }
}

// MARK: - Characters list event handling
extension CharactersCoordinator: CharactersListViewEventHandling {
    func handle(event: CharactersListView.Event) {
        switch event {
        case let .didSelectCharacter(character):
            navigationController.pushViewController(makeCharacterDetail(for: character), animated: true)
        }
    }
}

// MARK: - Characters detail event handling
extension CharactersCoordinator: CharacterDetailViewEventHandling {
    func handle(event: CharacterDetailView.Event) {
        switch event {
        case let .didSelectEpisode(episode):
            navigationController.pushViewController(makeEpisodeDetail(for: episode), animated: true)
        case let .didSelectLocation(id):
            navigationController.pushViewController(makeLocationDetail(with: id), animated: true)
        }
    }
}

// MARK: - Episode detail event handling
extension CharactersCoordinator: EpisodeDetailViewEventHandling {
    func handle(event: EpisodeDetailView.Event) {
        switch event {
        case let .didTapOnOpenWeb(url):
            navigationController.present(makeWebView(for: url), animated: true)
        case let .didSelectCharacter(character):
            navigationController.pushViewController(makeCharacterDetail(for: character), animated: true)
        }
    }
}

// MARK: - Location detail event handling
extension CharactersCoordinator: LocationDetailViewEventHandling {
    func handle(event: LocationDetailViewController.Event) {
        switch event {
        case let .didSelectCharacter(character):
            navigationController.pushViewController(makeCharacterDetail(for: character), animated: true)
        }
    }
}
