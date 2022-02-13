//
//  SlotMachineViewController.swift
//  YSSlotMachineGB
//
//  Created by Ярослав on 13.02.2022.
//

import UIKit
import Combine
import CombineCocoa

class SlotMachineViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    private var subscriptions = Set<AnyCancellable>()
    
    let loopingMargin: Int = 40
    
    // Data
    let slotItems = ["🍉", "💎", "🍓", "🍋"]
    
    lazy var pickerData = [self.slotItems, self.slotItems, self.slotItems]
    lazy var maxPickerRow = self.pickerData[0].count
    
    // Outlets
    @IBOutlet weak var slotPickerView: UIPickerView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubscriptions()
        setupPickerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for i in 0...2 { spinByRandom(for: i) }
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
    private func setupUI() {
        titleLabel.text = "Крути эту штуку..."
    }
    
    private func setupSubscriptions() {
        spinButton.tapPublisher.sink { _ in
            for i in 0...2 { self.spinByOne(for: i) }
        }.store(in: &subscriptions)
    }
    
    private func setupPickerView() {
        slotPickerView.delegate = self
        slotPickerView.dataSource = self
        
        slotPickerView.selectRow((loopingMargin / 2) * maxPickerRow, inComponent: 0, animated: false)
        slotPickerView.selectRow((loopingMargin / 2) * maxPickerRow, inComponent: 1, animated: false)
        slotPickerView.selectRow((loopingMargin / 2) * maxPickerRow, inComponent: 2, animated: false)
    }
    
    private func spinByOne(for row: Int) {
        slotPickerView.selectRow(slotPickerView.selectedRow(inComponent: row) + 1, inComponent: row, animated: true)
    }
    
    private func spinByRandom(for row: Int) {
        slotPickerView.selectRow(slotPickerView.selectedRow(inComponent: row) + Int.random(in: 1...maxPickerRow), inComponent: row, animated: true)
    }
}
