//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Brais Moure on 19/2/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

final class MemberListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeBackButtom()
        tableView.tableFooterView = UIView()
        
        // Asignamos delegado
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc private func houseDidChange(notification: Notification) {
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa de userInfo
        let house = info[HOUSE_KEY] as? House
        
        // Actualizar el modelo
        guard let model = house?.sortedMembers else {
            return
        }
        self.model = model
        
        // Sincronizar la vista
        self.tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource
extension MemberListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "MemberCell"

        // Preguntar por una celda (a una cache) o crearla
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if(cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            cell?.westerosCellView()
        }
        
        // Descubrir la persona que tenemos que mostrar
        let person = model[indexPath.row]
        
        // Sincronizar celda y persona
        cell?.textLabel?.text = person.fullName
        
        // Devolver la celda
        return cell!
    }
    
    // Tiene mejor rendimiento sincronizar aquí
    //func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { }
    
}

// MARK: - UITableViewDelegate
extension MemberListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let person = model[indexPath.row]
        
        // Creamos el EpisodeDetailVC
        let memberDetailViewController = MemberDetailViewController(model: person)
        
        // Hacemos push
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
    
}
