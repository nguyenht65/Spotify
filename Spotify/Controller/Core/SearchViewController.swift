//
//  SearchViewController.swift
//  Spotify
//
//  Created by NguyenHT on 03/04/2022.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    private let searchController: UISearchController = {
        let viewController = UISearchController(searchResultsController: SearchResultsViewController())
        viewController.searchBar.placeholder = "Songs, Artists, Albums"
        viewController.searchBar.searchBarStyle = .minimal
        viewController.definesPresentationContext = true
        return viewController
    }()
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(150)),
                subitem: item,
                count: 2)
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            return NSCollectionLayoutSection(group: group)
        }))
    
    private var categories = [Category]()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        collectionView.register(CategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        
        APICaller.shared.getCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self?.categories = categories
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else  {
            return
        }
        
        resultsController.delegate = self
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    resultsController.update(with: results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        // resultsController.update(with: results)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
//        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
//              let query = searchController.searchBar.text,
//              !query.trimmingCharacters(in: .whitespaces).isEmpty else  {
//            return
//        }
//
//        APICaller.shared.search(with: query) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let results):
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        print(query)
    }
    
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    func didTapResult(_ result: SearchResult) {
        switch result {
        case .artist(model: let model):
          break
        case .album(model: let model):
            let viewController = AlbumViewController(album: model)
            viewController.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(viewController, animated: true)
        case .playlist(model: let model):
            let viewController = PlaylistViewController(playlist: model)
            viewController.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(viewController, animated: true)
        case .track(model: let model):
            break
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath
        ) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let category = categories[indexPath.row]
        cell.configure(with: CategoryCollectionViewCellViewModel(
            title: category.name,
            artworkURL: URL(string: category.icons.first?.url ?? ""))
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        let viewController = CategoryViewController(category: category)
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
}
