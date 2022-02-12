//
//  LargePosterCell.swift
//  ImdbClone
//
//  Created by Vishwajeet Singh on 12/02/22.
//

import UIKit

class LargePosterCell: UITableViewCell {

    @IBOutlet weak var bgVw: UIView!
    
    @IBOutlet weak var infoVw: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblYear: UILabel!
    
    @IBOutlet weak var imgVwPoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.infoVw.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    override func prepareForReuse() {
    
        
    }
    
    func configureCell(data:MovieItem) {
                
        self.imgVwPoster.sd_setImage(with: URL(string: data.posterImg), completed: nil)
        self.lblName.text = data.title
        self.lblYear.text = data.year
    }
}
