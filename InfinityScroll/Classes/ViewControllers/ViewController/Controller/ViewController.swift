//
//  ViewController.swift
//  InfinityScroll
//
//  Created by Олег on 04.07.2021.
//

import UIKit

// MARK: ViewController
final class ViewController: UIViewController {
    /// Outlet
    @IBOutlet weak var tableView: UITableView!
    
    /// Константы
    /// Название экрана
    private let screenName = "Infinity Scroll"
    /// ViewModel
    private let viewModel = ViewModel()
    
    
    /// Методы жизненного цикла
    /// ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Настройка таблицы
        self.setupTableView()
    }
    
    /// ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Настройка отображения NavBar
        self.setupNavigationBar()
    }
    
    
    /// Настройка таблицы
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    /// Настройка отображения NavBar
    private func setupNavigationBar() {
        self.title = self.screenName
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    /// Кол-во секций в таблице
    /// - Parameter tableView: UITableView
    /// - Returns: Int
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.getSectionsCount()
    }
    
    /// Кол-во ячеек в секции
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: Int
    /// - Returns: Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Общее кол-во модераторов + одна ячейка, с анимацией загрузки
        return self.viewModel.getCellsCount(for: section)
    }
    
    /// Сформировать ячейку
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: IndexPath
    /// - Returns: UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.viewModel.getCell(for: tableView, by: indexPath)
        return cell
    }
    
    /// Обработка скролла таблицы пользователем
    /// - Parameter scrollView: UIScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        /// Если можно получить больше данных и пользователь добрался до конца таблицы, отображаем ячейку с загрузкой и тянем новые данные
        if self.viewModel.canGetMoreData && (offsetY > contentHeight - scrollView.frame.height) {
            self.viewModel.fetchData {
                DispatchQueue.main.async { [weak self] in
                    guard let _self = self else { return }
                    _self.tableView.reloadData()
                }
            }
        }
    }
}

