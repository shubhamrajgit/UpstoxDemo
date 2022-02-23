//
//  UTPortfolioVC.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 12/02/22.
//

import UIKit

final class UTPortfolioVC: UIViewController {
    
    @IBOutlet private weak var segmentView: UIView!
    @IBOutlet private weak var containerView: UIView!
    private var segmentedControl: UTSegmentControl?
    private var pageController: UIPageViewController?
    private var arrVC:[UIViewController] = []
    private var currentPage: Int = 0
    
    // MARK: Positions ViewController
    lazy private var vcPosition: UTPositionsVC = {
        var viewController = UTPositionsVC.instantiateViewController()
        return viewController
    }()
    
    // MARK: Holdings ViewController
    lazy private var vcHolding: UTHoldingVC = {
        var viewController = UTHoldingVC.instantiateViewController()
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSegmentControl()
        self.setupPageController()
        arrVC.append(vcPosition)
        arrVC.append(vcHolding)
    }
    
    private func setupSegmentControl() {
        segmentedControl = UTSegmentControl.init(frame: segmentView.bounds)
        if let sgControl = segmentedControl {
            sgControl.backgroundColor = .white
            sgControl.commaSeperatedButtonTitles = "POSITIONS, HOLDINGS"
            sgControl.addTarget(self, action: #selector(onChangeOfSegment(_:)), for: .valueChanged)
            self.segmentView.addSubview(sgControl)
        }
    }
    
    private func setupPageController() {
        pageController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        guard let pgControl = pageController else {
            return
        }
        pgControl.view.backgroundColor = UIColor.clear
        pgControl.delegate = self
        pgControl.dataSource = self
        
        for svScroll in pgControl.view.subviews as! [UIScrollView] {
            svScroll.delegate = self
        }
        
        pgControl.view.frame = self.containerView.bounds
        
        pgControl.setViewControllers([vcPosition], direction: .forward, animated: false, completion: nil)
        
        self.addChild(pgControl)
        self.containerView.addSubview(pgControl.view)
        pgControl.didMove(toParent: self)
    }
}

//MARK: - Page View Controller Datasource, Delegate
extension UTPortfolioVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index - 1
        }
        
        if(index < 0) {
            return nil
        }
        else {
            return arrVC[index]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index + 1
        }
        
        if(index >= arrVC.count) {
            return nil
        }
        else {
            return arrVC[index]
        }
    }
    
    func pageViewController(_ pageViewController1: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if(completed), let sgmntControl = self.segmentedControl {
            currentPage = arrVC.firstIndex(of: (pageViewController1.viewControllers?.last)!) ?? 0
            sgmntControl.updateSegmentedControlSegs(index: currentPage)
            
        }

    }
    
    private func indexofviewController(viewCOntroller: UIViewController) -> Int {
        if(arrVC .contains(viewCOntroller)) {
            return arrVC.firstIndex(of: viewCOntroller)!
        }
        
        return -1
    }
}

//MARK: - UISCrollView Delegate
extension UTPortfolioVC: UIScrollViewDelegate {
    
}

extension UTPortfolioVC {
    @objc func onChangeOfSegment(_ sender: UTSegmentControl) {
        
        guard let pgControl = pageController else {
            return
        }
        switch sender.selectedSegmentIndex {
        case 0:
            pgControl.setViewControllers([arrVC[0]], direction: .reverse, animated: true, completion: nil)
            currentPage = 0
            
        case 1:
            pgControl.setViewControllers([arrVC[1]], direction: .forward, animated: true, completion: nil)
                currentPage = 1
        default:
            break
        }
    }
}
