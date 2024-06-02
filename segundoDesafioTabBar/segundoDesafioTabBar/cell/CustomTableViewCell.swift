//
//  CustomTableViewCell.swift
//  segundoDesafioTabBar
//
//  Created by Jefferson Alves on 08/05/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var legendLabel: UILabel!
    @IBOutlet weak var photosImageView: UIImageView!
    
    static let identifier: String = "CustomTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib () -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
        
    }
    
    func setup(data: Profile ){
        legendLabel.text = data.name
        photosImageView.image = data.image
    }
    
    
    
    
}
