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
    var isSpinning = false
    var isPlaying = false
    
    let loopingMargin: Int = 4000

    // Data
    let slotItems = ["🍒", "💎", "🍋"]
    
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
        self.isPlaying = true
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
        let timerPublisher = Timer.publish(every: 0.01, on: .main, in: .default).autoconnect().share()
        timerPublisher.sink { _ in
            guard self.isSpinning else { return }
            for i in 0...2 { self.spinByRandom(for: i) }
        }.store(in: &subscriptions)
   
        spinButton.tapPublisher.sink { _ in
            self.isSpinning.toggle()
            
            if self.isPlaying {
                let slotEmoji1 = self.pickerData[0][self.slotPickerView.selectedRow(inComponent: 0) % self.maxPickerRow]
                let slotEmoji2 = self.pickerData[1][self.slotPickerView.selectedRow(inComponent: 1) % self.maxPickerRow]
                let slotEmoji3 = self.pickerData[2][self.slotPickerView.selectedRow(inComponent: 2) % self.maxPickerRow]

                if slotEmoji1 == slotEmoji2 && slotEmoji2 == slotEmoji3 {
                    self.titleLabel.text = "Вау! Ты выиграл, чувак!"
                } else {
                    self.titleLabel.text = "Не повезло, попробуй еще раз!"
                }
                
            } else {
                self.titleLabel.text = self.isSpinning ? "Удачи!" : "Крути эту штуку..."
            }
            if self.isSpinning {
                self.titleLabel.text = "Удачи!"
            }
            
            self.spinButton.setTitle(self.isSpinning ? "Стоп!" : "Крутить!", for: .normal)
        }.store(in: &subscriptions)
    }
    
    private func setupPickerView() {
        slotPickerView.delegate = self
        slotPickerView.dataSource = self
        
        slotPickerView.selectRow(loopingMargin / 2 * maxPickerRow, inComponent: 0, animated: false)
        slotPickerView.selectRow(loopingMargin / 2 * maxPickerRow, inComponent: 1, animated: false)
        slotPickerView.selectRow(loopingMargin / 2 * maxPickerRow, inComponent: 2, animated: false)
    }
    
    private func spinByOne(for row: Int) {
        slotPickerView.selectRow(slotPickerView.selectedRow(inComponent: row) + 1, inComponent: row, animated: true)
    }
    
    private func spinByRandom(for row: Int) {
        slotPickerView.selectRow(slotPickerView.selectedRow(inComponent: row) + Int.random(in: 1...maxPickerRow), inComponent: row, animated: true)
    }
}
