//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

let SEASON_DID_CHANGE_NOTIFICATION_NAME = "SeasonDidChange"
let SEASON_KEY = "SeasonKey"

protocol SeasonListViewControllerDelegate: class {

    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
}

final class SeasonListViewController: UITableViewController {
    
    // MARK: - Properties
    private let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    init(model: [Season]) {
        self.model = model
        super.init(style: .plain)
        title = "Seasons"
    }
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()        
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SeasonCell"
        
        // Preguntar por una celda (a una cache) o crearla
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if(cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            cell?.westerosCellView()
        }
        
        // Descubrir la temporada que tenemos que mostrar
        let season = model[indexPath.row]
        
        // Sincronizar celda y temporada
        cell?.textLabel?.text = season.title
        
        // Devolver la celda
        return cell!
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Descubrir la temporada que tenemos que mostrar
        let season = model[indexPath.row]
        
        if(splitViewController!.isCollapsed) {
            if let detailViewController = delegate as? UIViewController {
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    // Estamos en iPad
                    splitViewController?.showDetailViewController(detailViewController.wrappedInNavigation(), sender: nil)
                } else if UIDevice.current.userInterfaceIdiom == .phone {
                    // Estamos en iPhone
                    
                    // Crear un controlador de detalle de esa casa
                    let seasonDetailViewController = SeasonDetailViewController(model: season)
                    
                    // Hacer un push
                    navigationController?.pushViewController(seasonDetailViewController, animated: true)
                }
            }
        }
        
        // Avisamos al delegado
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        // Mando la misma info a través de notificaciones
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: Notification.Name.init(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY:season])
        notificationCenter.post(notification)
    }
    
}
