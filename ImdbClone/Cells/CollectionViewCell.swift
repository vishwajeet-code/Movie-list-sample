//
//  CollectionViewCell.swift
//  ImdbClone
//
//  Created by Vishwajeet Singh on 12/02/22.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgVw: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblYear: UILabel!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var bgVw: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.bgVw.layer.cornerRadius = 5.0
        self.bgVw.clipsToBounds = true
    }

    override func prepareForReuse() {
        
        self.imgVw.image = nil
        self.lblTitle.text = nil
        self.lblYear.text = nil
        self.lblType.text = nil
    }
    
    func configureCell(data:MovieItem) {
        
        self.imgVw.sd_setImage(with: URL(string: data.posterImg), completed: nil)
        self.lblTitle.text = data.title
        self.lblYear.text = data.displayDate
        self.lblType.text = data.type.rawValue
    }
    
}
