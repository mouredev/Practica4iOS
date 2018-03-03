//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Brais Moure on 15/2/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

let HOUSE_DID_CHANGE_NOTIFICATION_NAME = "HouseDidChange"
let HOUSE_KEY = "HouseKey"
let LAST_HOUSE = "LastHouse"

protocol HouseListViewControllerDelegate: class {
    // should, will, did
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House)
}

final class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    private let model: [House]
    weak var delegate: HouseListViewControllerDelegate?
    
    init(model: [House]) {
        self.model = model
        super.init(style: .plain)
        title = "Westeros"
    }
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        let lastRow = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        tableView.selectRow(at: IndexPath(row: lastRow, section: 0), animated: true, scrollPosition: .top)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "HouseCell"
        
        // Descubrir cuál es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if(cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            cell?.westerosCellView()
        }
        
        // Sincroniza house (model) con cell (vista)
        cell?.textLabel?.text = house.name
        cell?.imageView?.image = house.sigil.image
        
        return cell!
    }
    
    // MARK: - Table view delegate    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Averiguar qué casa han pulsado
        let house = model[indexPath.row]
        
        if(splitViewController!.isCollapsed) {
            if let detailViewController = delegate as? UIViewController {
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    // Estamos en iPad
                    splitViewController?.showDetailViewController(detailViewController.wrappedInNavigation(), sender: nil)
                } else if UIDevice.current.userInterfaceIdiom == .phone {
                    // Estamos en iPhone
                    
                    // Crear un controlador de detalle de esa casa
                    let houseDetailViewController = HouseDetailViewController(model: house)
                    
                    // Hacer un push
                    navigationController?.pushViewController(houseDetailViewController, animated: true)
                }
            }
        }
        
        // Avisamos al delegado
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Mando la misma info a través de notificaciones
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: Notification.Name.init(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY:house])
        notificationCenter.post(notification)
        
        // Guardar las coordenadas (section, row) de la última casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
    
}

extension HouseListViewController {
    
    private func saveLastSelectedHouse(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_HOUSE)
        // Por si las moscas...
        defaults.synchronize()
    }
    
    func lastSelectedHouse() -> House {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        // Averiguar la casa de ese row
        let house = model[row]
        // Devolverla
        return house
    }
    
}
