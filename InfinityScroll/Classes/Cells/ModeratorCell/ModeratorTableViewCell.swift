//
//  ModeratorTableViewCell.swift
//  InfinityScroll
//
//  Created by Олег on 04.07.2021.
//

import UIKit

final class ModeratorTableViewCell: UITableViewCell {
    /// Outlet
    @IBOutlet weak var titleLabel: UILabel!
    
    /// ViewModel
    var cellViewModel: ModeratorCellVM? {
        didSet {
            guard let vm = cellViewModel else { return }
            
            if oldValue?.title != vm.title {
                self.setTitle(vm.title)
            }
        }
    }

    /// AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Обработка выбора ячейки
    /// - Parameters:
    ///   - selected: выбрана ли ячейка
    ///   - animated: анимация выбора
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    /// Установка названия ячейки
    /// - Parameter value: название
    private func setTitle(_ value: String?) {
        self.titleLabel.text = value
    }
}
