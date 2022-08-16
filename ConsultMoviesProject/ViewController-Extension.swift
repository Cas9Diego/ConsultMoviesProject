//
//  ViewController-Extension.swift
//  ConsultMoviesProject
//
//  Created by Diego Castro on 15/08/22.
//

import Foundation
import UIKit

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
