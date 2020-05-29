//
//  BasisCardViewController.swift
//  Basis Task iOS
//
//  Created by mac on 29/05/20.
//  Copyright © 2020 Ganesh iOS. All rights reserved.
//

import UIKit

class BasisCardViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var basisCollectionView: UICollectionView!
    @IBOutlet weak var basisPageControl: UIPageControl!
    
    // MARK: - ViewModel Instances
    
    lazy var basisCardVM: BasisCardViewModel = {
        let viewModel = BasisCardViewModel()
        return viewModel
    }()
    
    //
    private var currentPage: Int = 0
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        /**
         Setup the CollectionView & Flow Layout.
         */
        self.setupCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         Fetch the Data from JSON File.
         */
        self.fetchJsonData()
    }
    
    // MARK: - IBActions
    
    @IBAction func goToFirstBtnAction(_ sender: Any) {
        /**
         Scroll to First Index. To start Again.
         */
        DispatchQueue.main.async {
            self.basisCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - Setup Methods

extension BasisCardViewController {
    
    /**
     Setup the Collection View Delegate & Datasource.
     */
    private func setupCollectionView() {
        /// Register Collection Cell.
        self.basisCollectionView.register(UINib(nibName: AppConstants.basisCollectionCell, bundle:nil), forCellWithReuseIdentifier:AppConstants.basisCollectionCell)
        ///
        self.basisCollectionView.delegate = self
        self.basisCollectionView.dataSource = self
        /// Setup the Collection View Layout.
        self.collectionViewLayoutSetup()
    }
    
    /**
     Fetch the JSON Data from JSON File. And load the data in to Collection View.
     */
    private func fetchJsonData() {
        ///
        self.basisCardVM.getCardsDataFromJSON(success: { [weak self] (isSuccess) in
            print("Status: \(isSuccess)")
            ///
            DispatchQueue.main.async { self?.basisCollectionView.reloadData() }
        }) { (error) in
            print(error)
        }
    }
    
    /**
     CollectionView Layout Setup for Horizontal Paging center.
     */
    private func collectionViewLayoutSetup() {
        let layout = CenterCellCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0)
        self.basisCollectionView.collectionViewLayout = layout
    }
}

// MARK: - CollectionView Delegates

extension BasisCardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ///
        let cardsCount = self.basisCardVM.getCardsCount()
        self.basisPageControl.numberOfPages = cardsCount
        ///
        return cardsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ///
        guard let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.basisCollectionCell, for: indexPath) as? BaisisCardCollectionCell
            else { return UICollectionViewCell() }
        ///
        cardCell.bindCardData(with: self.basisCardVM.getCardItem(at: indexPath))
        return cardCell
    }
}

// MARK: - CollectionViewFlowLayout

extension BasisCardViewController: UICollectionViewDelegateFlowLayout {
    /**
     Return the size according to your requirement. Full screen in our Case.
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        ///
        let cellWidth = collectionView.frame.size.width
        let cellHeight = collectionView.frame.size.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    /**
     Return the line spacing value in CGFloat format. In our case it is "0".
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /**
     Customize Page Control and Last index screen button changes.
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.basisCollectionView {
            self.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            self.basisPageControl.currentPage = currentPage
        }
    }
}
