//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

final class SeasonDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var seasonReleaseDateLabel: UILabel!
    @IBOutlet weak var seasonEpisodesNumberLabel: UILabel!
    @IBOutlet weak var episodeListButton: UIButton!
    
    // MARK: - Properties
    var model: Season
    
    // MARK: - Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        episodeListButton.layer.cornerRadius = 5
    }
    
    // 1: Voy a aparecer
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.current.userInterfaceIdiom == .phone {
            customizeBackButtom()
        }
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
        seasonNameLabel.text = model.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        seasonReleaseDateLabel.text = "Release date: \(dateFormatter.string(from: model.releaseDate))"
        seasonEpisodesNumberLabel.text = "Number of episodes: \(model.sortedEpisodes.count)"
        episodeListButton.setTitle("See full \(model.title) episode list".uppercased(), for: .normal)
        title = model.title
    }
    
    // MARK: - UI
    
    private func setupUI() {
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        episodesButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = episodesButton
    }
    
    @objc private func displayEpisodes() {
        showEpisodesList()
    }

    @IBAction func episodeListButtonAction(_ sender: Any) {
        showEpisodesList()
    }
    
    private func showEpisodesList() {
        
        // Creamos el EpisodeVC
        let episodeViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // Hacemos push
        navigationController?.pushViewController(episodeViewController, animated: true)
    }
    
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
    
}
