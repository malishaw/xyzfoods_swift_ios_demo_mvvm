//
//  DemoTableViewCell.swift
//  XYZ Foods
//
//  Created by Maheesha on 12/8/20.
//

import UIKit

class DemoTableViewCell: UITableViewCell {
    
    @IBOutlet var cellLable : UILabel!
    @IBOutlet var cellImageView : UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
