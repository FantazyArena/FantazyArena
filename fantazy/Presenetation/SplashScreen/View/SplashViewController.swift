import UIKit
import Lottie

extension UILabel {
    func applyGradientText(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

        let image = UIGraphicsImageRenderer(bounds: gradientLayer.bounds).image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }

        self.textColor = UIColor(patternImage: image)
    }
}


class SplashViewController: UIViewController {
    
    private var animationView: AnimationView!
    
    override func loadView() {
        super.loadView()
        
        let nib = UINib(nibName: "SplashViewController", bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        showLottie()
    }
    
    private func showLottie() {
        animationView = AnimationView(name: "splash")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300)
        ])

        let titleLabel = UILabel()
        titleLabel.text = "Fantazy"
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.alpha = 0
        titleLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        let attributed = NSMutableAttributedString(string: "Fantazy")
        attributed.addAttribute(.kern, value: 2.0, range: NSRange(location: 0, length: attributed.length))
        titleLabel.attributedText = attributed
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        animationView.play { [weak self] finished in
            guard let self = self, finished else { return }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                titleLabel.applyGradientText(colors: [
                    UIColor(red: 37/255, green: 37/255, blue: 169/255, alpha: 1),
                    UIColor(red: 145/255, green: 60/255,  blue: 211/255, alpha: 1)
                ])
            }

            UIView.animate(
                withDuration: 0.9,
                delay: 0.1,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.3,
                options: .curveEaseOut,
                animations: {
                    titleLabel.alpha = 1
                    titleLabel.transform = .identity
                },
                completion: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.navigateToHome()
                    }
                }
            )
        }
    }
    
    private func navigateToHome() {
        AppCoordinator.shared.showHome()
    }
}
