import UIKit

class HomeViewController: UIViewController,
                        UICollectionViewDelegate,
                          UICollectionViewDelegateFlowLayout,
                          UICollectionViewDataSource, HomeViewProtocol {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let totalSpacing: CGFloat = 24
    var presenter: HomePresenterProtocol!
    var coordinator : AppCoordinator?
    
    
    override func loadView() {
        super.loadView()
        
        let nib = UINib(nibName: "HomeViewController", bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomePresenter(view: self)
        
        collectionView.register(UINib(nibName: "SportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SportCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getSportsCount()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCollectionViewCell", for: indexPath) as! SportCollectionViewCell
        
        cell.config(with: presenter.getSport(by: indexPath.row))
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return totalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return totalSpacing / 2;
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.bounds.width - totalSpacing) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = presenter.getSport(by: indexPath.row)
        
        coordinator?.navigateToLeagues(sport: sport)
        
    }
    func navigateToSportDetails(sport: Sport){
        //TODO: navigate to sport details
    }
}
