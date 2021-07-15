//
//  ViewModel.swift
//  InfinityScroll
//
//  Created by Олег on 04.07.2021.
//

import Foundation
import UIKit

// MARK: ViewModel
final class ViewModel {
    /// Список модераторов
    private var moderators: [ModeratorItem] = []
    /// Отображение лоадера
    var canGetMoreData: Bool = true
    /// Номер страницы
    var page = 1
    /// Возможно ли получить еще данные
    var hasMore = true
    /// Сетевой менеджер экрана
    private var networkManager: ViewControllerNetworkManager = ViewControllerNetworkManager()
    
    /// Получить кол-во секций
    /// - Returns: Int
    func getSectionsCount() -> Int {
        /// Если есть возможность получить еще информацию, тогда отображаем ячейку с лоадером
        if self.hasMore {
            return 2
        } else {
            /// Запрещаем тянуть запрос, так как данных для отображения больше нет
            self.canGetMoreData = false
            return 1
        }
    }
    
    /// Получить кол-во ячеек в секции
    /// - Parameter section: номер секции
    /// - Returns: Int
    func getCellsCount(for section: Int) -> Int {
        if section == 0 {
            return self.moderators.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    /// Получить ячейку
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - index: Int
    /// - Returns: UITableViewCell
    func getCell(for tableView: UITableView, by indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "ModeratorTableViewCell") as? ModeratorTableViewCell {
            cell.cellViewModel = self.makeModeratorCellVM(index: indexPath.row)
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1, let cell = tableView.dequeueReusableCell(withIdentifier: "LoaderTableViewCell") as? LoaderTableViewCell {
            cell.animateLoader(true)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    /// Получить данные для таблицы
    /// - Parameter completion: Необходим для обновления таблицы
    func fetchData(completion: @escaping () -> Void) {
        self.canGetMoreData = false
        
        self.networkManager.getModeratorsList(page: self.page) { [weak self] (response) in
            guard let _self = self, let moderators = response.items else { return }
            /// Сохраняем данные о новых модераторах
            _self.moderators.append(contentsOf: moderators)
            /// Разрешаем выполнять следующие запросы
            _self.canGetMoreData = true
            /// Увелечение номера страницы
            _self.page += 1
            /// Запоминаем, есть ли еще данные на сервере
            _self.hasMore = response.hasMore ?? false
            /// Обновляем таблицу
            completion()
        } failure: { (error) in
            print(error.localizedDescription)
        }
    }
    
    /// Создать ModeratorCellVM
    /// - Parameter index: индекс
    /// - Returns: ModeratorCellVM
    private func makeModeratorCellVM(index: Int) -> ModeratorCellVM? {
        /// Проверка, что индекс не превышает кол-во элементов
        guard moderators.count > index else { return nil }
        let moderator = moderators[index]
        let vm = ModeratorCellVM(title: moderator.displayName ?? "")
        return vm
    }
}
