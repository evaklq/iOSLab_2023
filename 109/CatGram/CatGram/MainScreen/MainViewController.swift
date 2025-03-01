//
//  ViewController.swift
//  CatGram
//
//  Created by Mac on 2023-10-28.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Declaration objects
    private let mainDataSourse = MainViewDataSourse()
    private let manager = PostsManager.postsManager
    private var mainView: MainView

    // MARK: - Init
    init() {
        if var user = UserManager.userManager.loginedUser {
            self.mainView = MainView(frame: CGRect(), user: &user)
            manager.configurePosts(user: user)
        } else {
            var user = User()
            self.mainView = MainView(frame: CGRect(), user: &user)
        }
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Load view
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.controller = self
        setDataSourse(mainView.postsCollectionView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = UserManager.userManager.loginedUser {
            self.mainView.updateAmount(user.amountOfPosts)
            manager.configurePosts(user: user)
            updateDataSourse()
        }
    }
}

// MARK: - Diffable Data Sourse
extension MainViewController {
    func showDetailScreen(_ indexPath: IndexPath) {
        let detailVC = DetailPostViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.currentPost = indexPath
        self.present(detailVC, animated: true, completion: nil)
    }
    func setDataSourse(_ postsCollectionView: UICollectionView) {
        mainDataSourse.setupDataSourse(postsCollectionView)
    }
    func updateDataSourse() {
        mainDataSourse.updateDataSourse(with: manager.getPostsSync())
    }
}

