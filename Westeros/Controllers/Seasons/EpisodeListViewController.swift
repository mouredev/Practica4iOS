//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

final class EpisodeListViewController: UITableViewController {
    
    // MARK: - Properties
    var model: [Episode]
    
    // MARK: - Initialization
    init(model: [Episode]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButtom()
        tableView.tableFooterView = UIView()
        
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Sync
    
    private func syncModelWithView() {
        
        // Si la vista no se ha iniciado por primera vez, no permitimos sincronizar
        guard let _ = self.view else {
            return
        }
        
        title = "\(model.first!.season!.title) episodes"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "EpisodeCell"
        
        // Preguntar por una celda (a una cache) o crearla
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if(cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            cell?.westerosCellView()
        }
        
        // Descubrir el episodio que tenemos que mostrar
        let episode = model[indexPath.row]
        
        // Sincronizar celda y episodio
        cell?.textLabel?.text = "\(indexPath.row + 1). \(episode.title)"
        
        // Devolver la celda
        return cell!
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let episode = model[indexPath.row]        
        
        // Creamos el EpisodeDetailVC
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        // Hacemos push
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
    
    // MARK: - Notifications
    @objc private func seasonDidChange(notification: Notification) {
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa de userInfo
        let season = info[SEASON_KEY] as? Season
        
        // Actualizar el modelo
        guard let model = season?.sortedEpisodes else {
            return
        }
        self.model = model
        
        // Sincronizar la vista
        syncModelWithView()
        self.tableView.reloadData()
    }
    
}
