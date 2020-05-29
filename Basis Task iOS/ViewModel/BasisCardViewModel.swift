//
//  BasisCardViewModel.swift
//  Basis Task iOS
//
//  Created by mac on 29/05/20.
//  Copyright © 2020 Ganesh iOS. All rights reserved.
//

import Foundation

internal class BasisCardViewModel {
    
    // MARK: - Property Instances
    
    /// User Availability API response
    private var CardDataResponse: BasisDataModel?
    
    // MARK: - Initializers
    
    internal init() {
    }
}


// MARK:- Helper Methods

extension BasisCardViewModel {
    
    /// Get Items Count for the Collection View.
    func getCardsCount() -> Int {
        let count = self.CardDataResponse?.data?.count
        return count ?? 0
    }
    
    ///
    func getCardItem(at index: IndexPath) -> BasisData? {
        let item = self.CardDataResponse?.data?[index.row]
        return item ?? nil
    }
}

// MARK: - Data Fetch

extension BasisCardViewModel {
    
    /// Cards - Data - GET From JSON File.
    func getCardsDataFromJSON(success: @escaping(Bool) -> Void, failure: @escaping(String) -> Void) {
        
        /// Get URL for Local Json File.
        guard let url = Bundle.main.url(forResource: "CardDataItems", withExtension: "json") else { return }
        
        /// Get Data and Decode that and Remove first Character.
        do {
            let demoData = try Data(contentsOf: url, options: .mappedIfSafe)
            var stringData = String(data: demoData, encoding: .utf8)
            _ = stringData?.removeFirst()
            
            /// Decode the Final Data Object to Modal Class.
            let jsonDataObj = try JSONDecoder().decode(BasisDataModel?.self, from: (stringData?.data(using: .utf8))!)
            
            /// If Success save the Object to local Instance.
            if let dataResult = jsonDataObj {
                self.CardDataResponse = dataResult
                success(true)
            } else {
                success(false)
            }
        } catch {
            /// If failure Send failure Response.
            failure(error.localizedDescription)
        }
    }
    
}
