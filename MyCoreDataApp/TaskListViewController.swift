//
//  TaskListViewController.swift
//  MyCoreDataApp
//
//  Created by Yevhen Shevchenko on 27.01.2021.
//

import UIKit

class TaskListViewController: UITableViewController {
    
    private let storageManager = StorageManager.shared
    
    private let cellId = "cell"
    private var tasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tasks = storageManager.fetchData()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.backgroundColor = .systemBlue
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addNewTask)
        )
    }
    
    @objc func addNewTask() {
        /*
        let newTaskVC = NewTaskViewController()
        newTaskVC.modalPresentationStyle = .fullScreen
        present(newTaskVC, animated: true)
        */
        
      showAlet()
    }

}

// MARK: - Table view data source

extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let task = tasks[indexPath.row]
        
        var content =  cell.defaultContentConfiguration()
        content.text = task.name
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - Table view delegate

extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let task = tasks[indexPath.row]
        
        showAlet(task) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            storageManager.delete(task)
        }
    }
}


// MARK: - Table view delegate

extension TaskListViewController {
    
    private func showAlet(_ task: Task? = nil, completion: (() -> Void)? = nil) {
        
        let title = task != nil ? "Update Task" : "New Task"
        let message = "What do you want to do?"
        
        let alertController = AlertController(title: title, message: message, preferredStyle: .alert)
        alertController.action(task: task) { newValue in
            if let task = task, let completion = completion  {
                self.storageManager.edit(task, newName: newValue)
                completion()
            } else {
                self.storageManager.save(newValue) { task in
                    self.tasks.append(task)
                    self.tableView.insertRows(
                        at: [IndexPath(row: self.tasks.count - 1, section: 0)],
                        with: .automatic
                    )
                }
            }
        }
        
        present(alertController, animated: true)
    }
}
