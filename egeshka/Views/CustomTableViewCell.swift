//
//  CustomTableViewCell.swift
//  egeshka
//
//  Created by Ildar Garifullin on 02.06.2025.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.backgroundColor = Colors.background
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
        contentView.layer.borderColor = Colors.border
        contentView.layer.borderWidth = 1
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with item: Item) {
        titleLabel.text = item.title
        contentView.backgroundColor = item.isSelected
        ? Colors.accent
        : .white
    }
}
