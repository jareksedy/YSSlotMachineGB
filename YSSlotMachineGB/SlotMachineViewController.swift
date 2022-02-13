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
    let pickerData = [["👻", "🦀", "🌞", "💔"], ["👻", "🦀", "🌞", "💔"], ["👻", "🦀", "🌞", "💔"]]
    lazy var maxPickerRow = self.pickerData[0].count
    
    // Outlets
    @IBOutlet weak var slotPickerView: UIPickerView!
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxPickerRow
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    // Private methods
    private func setupPickerView() {
        slotPickerView.delegate = self
        slotPickerView.dataSource = self
        
        slotPickerView.selectRow(Int.random(in: 0...maxPickerRow), inComponent: 0, animated: false)
        slotPickerView.selectRow(Int.random(in: 0...maxPickerRow), inComponent: 1, animated: false)
        slotPickerView.selectRow(Int.random(in: 0...maxPickerRow), inComponent: 2, animated: false)
    }
}
