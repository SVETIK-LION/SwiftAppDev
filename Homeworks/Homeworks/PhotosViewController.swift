import UIKit

final class PhotosViewController: UICollectionViewController {
    
    private var networkService: NetworkService = NetworkService()
    
    private var photos: [PhotoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
        title = "Photos"
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        networkService.getPhotos { [weak self] photos in
            self?.photos = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.backgroundColor = ColorTheme.currentTheme.backgroundColor
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = photos[indexPath.row]
        cell.setCellConfiguration(photoModel: photo)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellSize = width / 2 - 20
        return CGSize(width: cellSize, height: cellSize)
    }
}
