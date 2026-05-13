//
//  OnboardingCell.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 13/05/2026.
//
import UIKit
import Lottie

final class OnboardingCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    private var animationView: AnimationView?

    override func prepareForReuse() {
        super.prepareForReuse()
        animationView?.removeFromSuperview()
        animationView = nil
    }

    func configure(page: OnboardingPage) {

        titleLabel.text = page.title
        subtitleLabel.text = page.subtitle

        animationView?.removeFromSuperview()

        let animation = AnimationView(name: page.animationName)
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop

        containerView.addSubview(animation)

        NSLayoutConstraint.activate([
            animation.topAnchor.constraint(equalTo: containerView.topAnchor),
            animation.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            animation.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            animation.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])

        animation.play()

        animationView = animation
    }
}
