//
//  LoaderTableViewCell.swift
//  InfinityScroll
//
//  Created by Олег on 04.07.2021.
//

import UIKit

// MARK: LoaderTableViewCell
final class LoaderTableViewCell: UITableViewCell {
    /// Outlets
    @IBOutlet weak var loaderView: UIActivityIndicatorView!

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
    
    /// Вкл/выкл анимацию для лоадера
    /// - Parameter animated: Bool
    func animateLoader(_ animated: Bool) {
        if animated {
            self.loaderView.startAnimating()
        } else {
            self.loaderView.stopAnimating()
        }
    }

}
