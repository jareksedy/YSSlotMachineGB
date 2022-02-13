//
//  SlotMachineViewController.swift
//  YSSlotMachineGB
//
//  Created by Ярослав on 13.02.2022.
//

import UIKit

class SlotMachineViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let loopingMargin: Int = 40
    
    // Data
    let pickerData = [["🦀", "🌞", "💔"], ["🦀", "🌞", "💔"], ["🦀", "🌞", "💔"]]
    lazy var maxPickerRow = self.pickerData[0].count
    
    // Outlets
    @IBOutlet weak var slotPickerView: UIPickerView!
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
    }
    
    // Delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return loopingMargin * maxPickerRow
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row % maxPickerRow]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentIndex = row % maxPickerRow
        slotPickerView.selectRow((loopingMargin / 2) * maxPickerRow + currentIndex, inComponent: component, animated: false)
    }
    
    // Private methods
    private func setupPickerView() {
        slotPickerView.delegate = self
        slotPickerView.dataSource = self
        
        slotPickerView.selectRow((loopingMargin / 2) * maxPickerRow, inComponent: 0, animated: false)
        slotPickerView.selectRow((loopingMargin / 2) * maxPickerRow, inComponent: 1, animated: false)
        slotPickerView.selectRow((loopingMargin / 2) * maxPickerRow, inComponent: 2, animated: false)
    }
}
