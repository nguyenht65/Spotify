//
//  ViewController.swift
//  Spotify
//
//  Created by NguyenHT on 02/04/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSetting))
        fetchData()
    }

    private func fetchData() {
        APICaller.shared.getAvailableGenreSeeds { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                APICaller.shared.getRecommendations(genres: seeds) { result in
                    switch result {
                    case .success(let model):
                        break
                    case .failure(let error):
                        break
                    }
                }
            case .failure(let error):
                break
            }
        }
    }
    @objc func didTapSetting() {
        let viewController = SettingViewController()
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
}

