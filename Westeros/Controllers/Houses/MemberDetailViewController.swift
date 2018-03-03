//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

final class MemberDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    var model: Person
    
    // MARK: - Initialization
    init(model: Person) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButtom()
        
        setupUI()
        syncModelWithView()
    }
    
    // MARK: - Sync
    
    private func syncModelWithView() {
        
        // Si la vista no se ha iniciado por primera vez, no permitimos sincronizar
        guard let _ = self.view else {
            return
        }
        
        // Model -> View
        let imageName = model.name.lowercased()
        photoImageView.image = UIImage(named: "\(imageName).jpg") // Está claro que no es la mejor manera de hacerlo. Simplemente lo hago así para no alterar el modelo original
        nameLabel.text = model.fullName
        aliasLabel.text = model.alias
        houseNameLabel.text = model.house.name
        wordsLabel.text = model.house.words
        sigilImageView.image = model.house.sigil.image
        title = model.name
    }
    
    // MARK: - UI
    
    private func setupUI() {

        photoImageView.backgroundColor = UIColor.white
        photoImageView.layer.cornerRadius = photoImageView.bounds.height / 2
        //photoImageView.layer.borderWidth = 2
        //photoImageView.layer.borderColor = UIColor.black.cgColor
        photoImageView.clipsToBounds = true
        sigilImageView.backgroundColor = UIColor.white
        sigilImageView.layer.cornerRadius = sigilImageView.bounds.height / 2
        //sigilImageView.layer.borderWidth = 2
        //sigilImageView.layer.borderColor = UIColor.black.cgColor
        sigilImageView.clipsToBounds = true
    }

}
