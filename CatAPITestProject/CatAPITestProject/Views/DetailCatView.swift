//
//  DetailCatView.swift
//  CatAPITestProject
//
//  Created by Евгений on 25.11.21.
//

import UIKit

class DetailCatView: UIViewController {
    
    @IBOutlet weak var photoOfCatsCollectionView: UICollectionView!
    
    @IBOutlet weak var breedNameLbl: UILabel!
    @IBOutlet weak var breedDescriptionLbl: UILabel!
    @IBOutlet weak var breedTemperamentLbl: UILabel!
    
    var viewModel = DetailCatViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoOfCatsCollectionView.dataSource = self
        photoOfCatsCollectionView.delegate = self
        setupUI()
        getImage()
    }
    
    private func setupUI() {
        let breedName = viewModel.breed?.name
        breedNameLbl.text = breedName
        breedDescriptionLbl.text = viewModel.breed?.description
        breedTemperamentLbl.text = viewModel.breed?.temperament
        self.title = breedName
    }
    
    private func getImage() {
        viewModel.getImage { [weak self] in
            DispatchQueue.main.async {
                self?.photoOfCatsCollectionView.reloadData()
            }
        }
    }

}


extension DetailCatView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoOfCatsCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoOfCatCell
        let image = viewModel.images[indexPath.row]
        if let urlSrt = image.url {
            let url = URL(string: urlSrt)!
            DispatchQueue.global(qos: .userInitiated).async {
                UIImage.loadImageFromUrl(url: url) { image in
                    DispatchQueue.main.async {
                        cell.photoOfCatImageView.image = image
                        cell.photoOfCatImageView.contentMode = .scaleAspectFill
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeWidth = photoOfCatsCollectionView.frame.width
        let sizeHeight = photoOfCatsCollectionView.frame.height
        return CGSize(width: sizeWidth, height: sizeHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)

    }
    
}
