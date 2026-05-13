import UIKit

final class OnboardingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!

    var presenter: OnboardingPresenter!
    private var pages: [OnboardingPage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        presenter.viewDidLoad()
    }

    private func setupUI() {
        nextButton.layer.cornerRadius = 12
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }

        collectionView.register(UINib(nibName: "OnboardingCell", bundle: nil), forCellWithReuseIdentifier: "OnboardingCell")
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        presenter.nextTapped()
    }

    @IBAction func skipTapped(_ sender: UIButton) {
        presenter.skipTapped()
    }
}

extension OnboardingViewController: OnboardingViewProtocol {
    func setupPages(_ pages: [OnboardingPage]) {
        self.pages = pages
        pageControl.numberOfPages = pages.count
        collectionView.reloadData()
    }

    func updatePageScroll(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    func updateUIState(index: Int, isLast: Bool) {
        pageControl.currentPage = index
        nextButton.setTitle(isLast ? "Get Started" : "Next", for: .normal)
        
        skipButton.isHidden = isLast
    }
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        cell.configure(page: pages[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let page = Int(round(scrollView.contentOffset.x / width))
        presenter.didScrollToIndex(page)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let page = Int(round(scrollView.contentOffset.x / width))
        presenter.didScrollToIndex(page)
    }
}
