//
//  UTHoldingVC.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 12/02/22.
//

import UIKit

final class UTHoldingVC: UIViewController, UTStoryboardInstantiable, UTAlertable {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bottomPLView: UIView!
    @IBOutlet private weak var plBtn: UIButton!
    @IBOutlet private weak var plLabel: UILabel!
    
    //Bottom View
    @IBOutlet private weak var bottomSheetView: UIView!
    @IBOutlet private weak var currValLbl: UILabel!
    @IBOutlet private weak var totalInvstLbl: UILabel!
    @IBOutlet private weak var todayProfitLossLbl: UILabel!
    
    @IBOutlet private weak var verticalConstBottomSheet: NSLayoutConstraint!
    
    private var isBottomSheetPresented = false
    private var viewModel = UTHoldingVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.start()
    }
    
    private func setupView() {
        bottomPLView.roundedCorners(radius: 5.0, borderColor: UIColor.segmntSelColor)
    }
    
    private func start() {
        viewModel.fetchHoldingsData()
        viewModel.observerBlock = {  [weak self] (state) in
            DispatchQueue.main.async {
                switch state {
                case .dataLoaded:
                    debugPrint("Data Loaded")
                    self?.tableView.reloadData()
                    self?.setBottomSheetValues()
                case .dataFailed:
                    debugPrint("Data Failed")
                    //Handle Failure Alert
                    
                case .dataLoading:
                    debugPrint("Data Loading")
                    //Handle Loader
                    
                default:
                    debugPrint("Default")
                }
            }
        }
    }
    
    @IBAction func plBtnClicked(_ sender: UIButton) {
        self.setupBottomSheet()
    }
    
    private func setupBottomSheet() {
        let constant: CGFloat = isBottomSheetPresented ? -100.0 : 0
        self.bottomSheetView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.verticalConstBottomSheet.constant = constant
            self.view.layoutIfNeeded()
        } completion: { (_) in
            self.isBottomSheetPresented = !self.isBottomSheetPresented
            self.bottomSheetView.isHidden = !self.isBottomSheetPresented
        }
    }
    
    private func setBottomSheetValues() {
        let values = viewModel.calculateBottomSheetValues()
        
        self.plLabel.textColor = UTUtility.getColorFor(values.totalPL)
        self.plLabel.text = String(format: "%.2f", values.totalPL).addRupee()
        
        self.currValLbl.textColor = UTUtility.getColorFor(values.currVal)
        self.currValLbl.text = String(format: "%.2f", values.currVal).addRupee()
        
        self.totalInvstLbl.textColor = UTUtility.getColorFor(values.totalInv)
        self.totalInvstLbl.text = String(format: "%.2f", values.totalInv).addRupee()
        
        self.todayProfitLossLbl.textColor = UTUtility.getColorFor(values.todayPL)
        self.todayProfitLossLbl.text = String(format: "%.2f", values.todayPL).addRupee()
        
    }
}

//MARK: - UITableviewDatasource & Delegate
extension UTHoldingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let holdingCell = tableView.dequeueReusableCell(withIdentifier: UTHoldingTVC.identifier, for: indexPath) as? UTHoldingTVC {
            let cellVM = UTHoldingCellVM(model: viewModel.dataSource[indexPath.row])
            holdingCell.configureCell(viewModel: cellVM)
            return holdingCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
