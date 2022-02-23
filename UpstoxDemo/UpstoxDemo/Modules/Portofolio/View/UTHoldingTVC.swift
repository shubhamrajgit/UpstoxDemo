//
//  UTHoldingTVC.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 12/02/22.
//

import UIKit

final class UTHoldingTVC: UITableViewCell {
    
    static var identifier: String { return String(describing: self) }
    
    @IBOutlet private weak var symbolLbl: UILabel!
    @IBOutlet private weak var quantityLbl: UILabel!
    @IBOutlet private weak var ltpLbl: UILabel!
    @IBOutlet private weak var profitLossLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Custom Methods
    func configureCell(viewModel: UTHoldingCellVM) {
        symbolLbl.text = viewModel.symbol
        quantityLbl.text = viewModel.quantity
        ltpLbl.text = viewModel.ltp
        let plTuple = viewModel.getProfitLoss()
        profitLossLbl.text = plTuple.result
        profitLossLbl.textColor = plTuple.txtColor
    }

}
