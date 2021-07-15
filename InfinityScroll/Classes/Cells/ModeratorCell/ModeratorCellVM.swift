//
//  ModeratorCellVM.swift
//  InfinityScroll
//
//  Created by Олег on 04.07.2021.
//

import Foundation

// MARK: ModeratorCellVM
final class ModeratorCellVM {
    /// Название ячейки
    var title: String?
    
    
    /// Инициализатор
    /// - Parameter title: название
    init(title: String?) {
        self.title = title
    }
}
