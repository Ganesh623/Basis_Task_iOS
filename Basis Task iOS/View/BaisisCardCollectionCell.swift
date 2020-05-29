//
//  BaisisCardCollectionCell.swift
//  Basis Task iOS
//
//  Created by mac on 29/05/20.
//  Copyright © 2020 Ganesh iOS. All rights reserved.
//

import UIKit

class BaisisCardCollectionCell: UICollectionViewCell {

    @IBOutlet weak var basisCardView: CardView!
    @IBOutlet weak var basisTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - Setup Methods

extension BaisisCardCollectionCell {
    /**
     Bind the cell data with JSON Data Items.
     */
    func bindCardData(with itemData: BasisData?) {
        guard let item = itemData else { return }
        ///
        self.basisTextLabel.text = item.content
    }
}
