//
//  OnboardingPresenter.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 13/05/2026.
//

import Foundation

final class OnboardingPresenter {
    weak var view: OnboardingViewProtocol?
    var onFinish: (() -> Void)?
    private var currentIndex = 0
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(
            animationName: "sports",
            title: "Discover Your Favorite Sports",
            subtitle: "Choose a sport from the home screen to browse available leagues."
        ),
        OnboardingPage(
            animationName: "football",
            title: "Track Leagues and Matches",
            subtitle: "View upcoming fixtures, latest results, and all competing teams."
        ),
        OnboardingPage(
            animationName: "basketball",
            title: "Analyze Detailed Team Info",
            subtitle: "Select any team to see their full profile and current statistics."
        )
    ]

    init(view: OnboardingViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        view?.setupPages(pages)
        updateUI()
    }

    func nextTapped() {
        if currentIndex < pages.count - 1 {
            currentIndex += 1
            view?.updatePageScroll(index: currentIndex)
        } else {
            onFinish?()
        }
    }

    func skipTapped() {
        onFinish?()
    }

    func didScrollToIndex(_ index: Int) {
        if currentIndex != index {
            currentIndex = index
            updateUI()
        }
    }

    private func updateUI() {
        let isLast = currentIndex == pages.count - 1
        view?.updateUIState(index: currentIndex, isLast: isLast)
    }
}
