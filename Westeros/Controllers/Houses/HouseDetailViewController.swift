//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Brais Moure on 12/2/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

final class HouseDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var sigilDescription: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        // Primero, limpias tu propio desorden
        self.model = model
        // Llamas a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self))) // Es lo mismo que lo de abajo
        //super.init(nibName: nil, bundle: nil)
        //super.init(nibName: "HouseDetailViewController", bundle: Bundle(for: HouseDetailViewController.self))
    }
    
    // Chapuza de los de Cupertino relacionada con los nil. Nos obligan a poner, no darle importancia cuando no se usan Storyboads
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .phone {
            customizeBackButtom()
        }
    }
    
    // 1: Voy a aparecer
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        
        setupUI()
        syncModelWithView()
    }
    
    // 2: He aparecido
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // 3: Voy a desaparecer
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // 4: He desaparecido
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Sync
    
    private func syncModelWithView() {
        
        // Si la vista no se ha iniciado por primera vez, no permitimos sincronizar
        guard let _ = self.view else {
            return
        }
        
        // Model -> View
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        sigilDescription.text = model.sigil.description
        wordsLabel.text = "\"\(model.words)\""
        title = model.name
    }
    
    // MARK: - UI
    
    private func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        wikiButton.tintColor = UIColor.black
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        membersButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItems = [wikiButton, membersButton]
    }
    
    @objc private func displayWiki() {
        // Creamos el WikiVC
        let wikiViewController = WikiViewController(model: model)
        
        // Hacemos push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    
    @objc private func displayMembers() {
        // Creamos el MemberVC
        let memberViewController = MemberListViewController(model: model.sortedMembers)
        
        // Hacemos push
        navigationController?.pushViewController(memberViewController, animated: true)
    }
    
}

extension HouseDetailViewController: HouseListViewControllerDelegate {
    
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
    
}

