//
//  OnboardingContract.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 13/05/2026.
//

import Foundation

protocol OnboardingViewProtocol: AnyObject {
    func setupPages(_ pages: [OnboardingPage])
    func updatePageScroll(index: Int)
    func updateUIState(index: Int, isLast: Bool)
}
