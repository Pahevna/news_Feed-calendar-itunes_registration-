//
//  CreateEventPresenter.swift
//  dateBook
//
//  Created by mac on 09.06.2021.
//

import Foundation

protocol EventCreationViewProtocol: class {

  
}

protocol EventCreationPresenterProtocol: class {
    func didEditName(_ name: String)
    func didEditDescription(_ description: String)
    func didEditDateStart(_ dateStart: Date)
    func didEditDateEnd(_ dateEnd: Date)
    func didTapAddButton()
}

class EventCreationPresenter: EventCreationPresenterProtocol {
    
    weak var view: EventCreationViewProtocol?
    private let realmService: RealmServiceProtocol
    private var name: String?
    private var description: String?
    private var dateStart: Date?
    private var dateEnd: Date?
    
    required init(view: EventCreationViewProtocol, realmService: RealmServiceProtocol) {
        self.view = view
        self.realmService = realmService
    }
    
    func didEditName(_ name: String) {
        
        self.name = name
    }
    
    func didEditDescription(_ description: String) {
        
        self.description = description
    }
    
    func didEditDateStart(_ dateStart: Date) {
        
        self.dateStart = dateStart
    }
    
    func didEditDateEnd(_ dateEnd: Date) {
        
        self.dateEnd = dateEnd
    }
    
    func didTapAddButton() {
        
        realmService.saveEventToRealm(name: name ?? "", dateStart: dateStart ?? Date(), dataEnd: dateEnd ?? Date(), description: description ?? "")
    }
    
    
}