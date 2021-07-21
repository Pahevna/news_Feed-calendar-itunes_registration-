//
//  CreateEventViewController.swift
//  dateBook
//
//  Created by mac on 07.06.2021.
//

import UIKit

class EventCreationViewController: UIViewController {
    
    var presenter: EventCreationPresenterProtocol?
    
    private let cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "TrebuchetMS", size: 17) 
        cancelButton.titleLabel?.textAlignment = .center
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        return cancelButton
    }()
    
    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.gray, for: .normal)
        addButton.titleLabel?.font = UIFont(name: "TrebuchetMS", size: 17)
        addButton.titleLabel?.textAlignment = .center
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        return addButton
    }()
    
    private let eventLabel = UILabel(text: "New Event", font: UIFont(name: "TrebuchetMS", size: 17), aligment: .center)
      
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    


//        datePicker.addTarget(self, action: #selector(donePressed), for: .valueChanged)

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .orange
        view.backgroundColor = .systemBackground
        
        setConstraints()
        setupTableView()
    }
    
    private func setConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [cancelButton,eventLabel,addButton], axis: .horizontal, spacing: 30, distribution: .fillEqually)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
//    @objc private func donePressed() {
//
//        dateStartLabel.text = "\(datePicker.date)"
//        dateStartLabel.text = datePicker.date.convertFromDateToString(dateFormat: "d MMM yyyy HH:mm")
//    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        let nibEvent = UINib(nibName: "EventCreationTableViewCell", bundle: nil)
        tableView.register(nibEvent, forCellReuseIdentifier: "cellEvent")
        let nibDate = UINib(nibName: "DateTableViewCell", bundle: nil)
        tableView.register(nibDate, forCellReuseIdentifier: "cellDate")
        let nibDatePicker = UINib(nibName: "DatePickerTableViewCell", bundle: nil)
        tableView.register(nibDatePicker, forCellReuseIdentifier: "cellDatePicker")
    }
    
    @objc private func didTapAdd() {
        
        print("button clicked")
        presenter?.didTapAddButton()
    }
}

extension EventCreationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        textField.text = updatedText
        
//        if textField === nameTextField {
//            addButton.setTitleColor(.red, for: .normal)
//            presenter?.didEditName(updatedText)
//
//        } else if textField === descriptionTextField {
//            presenter?.didEditDescription(updatedText)
//
//        } else if textField === dateStartLabel {
//            presenter?.didEditDateStart(updatedText.convertToDate())
//
//        } else if textField === dateEndLabel {
//            presenter?.didEditDateEnd(updatedText.convertToDate())
//        }
       
        return false
    }
}

extension EventCreationViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .systemGray6
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellEvent", for: indexPath) as! EventCreationTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellDate", for: indexPath) as! DateTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}

extension EventCreationViewController: UITableViewDelegate {
    
}

extension EventCreationViewController: EventCreationViewProtocol {
    
    func showAlert(text: String) {
        
        let alert = UIAlertController(title: "Error", message: text,
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
}
