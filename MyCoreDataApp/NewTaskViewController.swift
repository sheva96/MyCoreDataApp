//
//  NewTaskViewController.swift
//  MyCoreDataApp
//
//  Created by Yevhen Shevchenko on 27.01.2021.
//

import UIKit
import CoreData

class NewTaskViewController: UIViewController {
    
//    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let buttton = UIButton()
        buttton.setTitle("Save", for: .normal)
        buttton.setTitleColor(.white, for: .normal)
        buttton.backgroundColor = .systemBlue
        buttton.layer.cornerRadius = 5
//        buttton.addTarget(self, action: #selector(save), for: .touchUpInside)
        return buttton
    }()
    
    private lazy var cancelButton: UIButton = {
        let buttton = UIButton()
        buttton.setTitle("Cancel", for: .normal)
        buttton.setTitleColor(.white, for: .normal)
        buttton.backgroundColor = .systemRed
        buttton.layer.cornerRadius = 5
        buttton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return buttton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setSubviews()
    }
    
//    @objc private func save() {
//        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
//        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
//
//        task.name = taskTextField.text
//
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch let error {
//                print(error)
//            }
//        }
//
//        dismiss(animated: true)
//    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
    
    private func setSubviews() {
        view.addSubview(taskTextField)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        
        setConstrains()
    }
    
    private func  setConstrains() {
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            taskTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            taskTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 8),
            cancelButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
