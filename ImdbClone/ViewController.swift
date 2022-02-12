//
//  ViewController.swift
//  ImdbClone
//
//  Created by Vishwajeet Singh on 11/02/22.
//

import UIKit

class ViewController: UIViewController {

    let networkManager =  NetworkManager()
    
    var viewModel:MoviewViewModel!
    
    @IBOutlet var collectionVw: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerXibs()
        self.viewModel = MoviewViewModel(networkManager: self.networkManager)
        self.viewModel.query = "God"
        self.viewModel.fetchSearchResults()
        self.bindViewModel()
    }
    
    func bindViewModel() {
        
        self.viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                
                self?.collectionVw.reloadData()
            }
        }
    }
    
    
    func registerXibs()
    {
        self.collectionVw.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionVw.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let cellData = self.viewModel.results[indexPath.item]
        cell.configureCell(data: cellData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cellData = self.viewModel.results[indexPath.item]
//        print(cellData.description)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.viewModel = DetailViewModel(item: cellData)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16.0

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width/2) - 16
        let height = width*2.1
        return CGSize(width: width, height: height)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        let currentOffset = self.collectionVw.contentOffset.y
        let maximumOffset = self.collectionVw.contentSize.height - self.collectionVw.frame.size.height

        if maximumOffset - currentOffset <= self.collectionVw.frame.size.height
        {
            if self.viewModel.state != .loadingData && self.viewModel.state != .empty
            {
                self.viewModel.pageNumber += 1
                self.viewModel.fetchSearchResults(loadMore: true)
            }
        }
    }
}

