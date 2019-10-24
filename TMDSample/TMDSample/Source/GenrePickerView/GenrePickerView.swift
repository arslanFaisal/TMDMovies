//
//  GenrePickerView.swift
//  TMDSample
//
//  Created by Arslan Faisal on 23/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

class GenrePickerView: UIView {
    
    @IBOutlet weak var genrePickerView  : UIPickerView!
    private var list                    : [Genre]?
    private var selectedGenre           : Genre? = nil
    
    
    func setupView(list: [Genre]) {
        self.list = list
        genrePickerView.delegate = self
    }
    
    func getSelectedGenre() -> Genre? {
        return selectedGenre
    }
    
}
//MARK: UI Picker Delegate and DataSource Methods
extension GenrePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let count = list?.count else {
            return 0
        }
        return count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "All"
        }
        return list?[row-1].name ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            selectedGenre = nil
        }else  {
            selectedGenre = list?[row-1]
        }
        
    }
    
}
