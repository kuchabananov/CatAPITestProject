//
//  ListOfCatsView.swift
//  CatAPITestProject
//
//  Created by Евгений on 25.11.21.
//

import UIKit

class ListOfCatsView: UIViewController {
    
    @IBOutlet weak var tableViewCats: UITableView!
    
    private var viewModel = ListOfCatsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableViewCats.delegate = self
        tableViewCats.dataSource = self
        getBreeds()
    }
    
    private func getBreeds() {
        viewModel.getBreeds { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewCats.reloadData()
            }
        }
    }
    
    private func setupUI() {
        tableViewCats.separatorStyle = .none
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCatDetail" else { return }
        guard let indexPath = tableViewCats.indexPathForSelectedRow else { return }

        let detailCatView = segue.destination as! DetailCatView
        detailCatView.viewModel.breed = viewModel.breeds[indexPath.row]
    }
    
}


extension ListOfCatsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell") as! CatListCell
        let breed = viewModel.breeds[indexPath.row]
        cell.catBreedLabel.text = breed.name
        if let urlStr = breed.image?.url {
            let url = URL(string: urlStr)!
            DispatchQueue.global(qos: .userInitiated).async {
                UIImage.loadImageFromUrl(url: url) { image in
                    DispatchQueue.main.async {
                        cell.catImage.image = image
                        cell.catImage.contentMode = .scaleAspectFill
                    }
                }
            }
        }
        return cell
    }
    
}
