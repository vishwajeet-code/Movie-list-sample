//
//  DetailViewController.swift
//  ImdbClone
//
//  Created by Vishwajeet Singh on 12/02/22.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var tblVw: UITableView!
    let networkManager =  NetworkManager()
    
    var viewModel:DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Detail"
        self.tblVw.isScrollEnabled = false
        self.registerXibs()
        self.bindViewModel()
    }
    

    func bindViewModel() {
        
        self.viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                
                self?.tblVw.reloadData()
            }
        }
    }
    
    func registerXibs()
    {
        self.tblVw.register(UINib(nibName: "LargePosterCell", bundle: nil), forCellReuseIdentifier: "LargePosterCell")
    }
    
}
extension DetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblVw.dequeueReusableCell(withIdentifier: "LargePosterCell", for: indexPath) as! LargePosterCell
        cell.configureCell(data: self.viewModel.detail)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.tblVw.bounds.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
}
