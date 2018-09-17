//
//  ViewController.swift
//  Demo
//
//  Created by Aj Mehra on 17/09/18.
//  Copyright © 2018 Aj Mehra. All rights reserved.
//

import UIKit

struct Account: Codable {
    var data: [String]
}

class ViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var displayLabel: UILabel!
    @IBOutlet private var pickerView: UIPickerView!

    // MARK: - Internal Variables'

    var account: Account?

    // MARK: - IBActions

    @IBAction private func showPicker(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        pickerView.isHidden = !sender.isSelected
    }

    private func createAccountList() {
        let json = """
        {
        "returnResult":1,
        "data":["account1", "account2", "account3","account4", "account5", "account6"]
        }
        """
        do {
            account = try JSONDecoder().decode(Account.self, from: json.data(using: .utf8)!)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func initUI() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountList()
        initUI()
        pickerView.reloadAllComponents()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return account?.data.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return account?.data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        displayLabel.text = account?.data[row]
    }
}
