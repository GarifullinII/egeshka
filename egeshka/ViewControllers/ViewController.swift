//
//  ViewController.swift
//  egeshka
//
//  Created by Ildar Garifullin on 02.06.2025.
//

import UIKit

final class ViewController: UIViewController {
    private var items: [Item] = [
        Item(id: 1, title: "Математика", isSelected: false),
        Item(id: 2, title: "Русский Язык", isSelected: false),
        Item(id: 3, title: "Физика", isSelected: false),
        Item(id: 4, title: "Химия", isSelected: false),
        Item(id: 5, title: "Биология", isSelected: false),
        Item(id: 6, title: "Информатика и ИКТ", isSelected: false),
        Item(id: 7, title: "История", isSelected: false),
        Item(id: 8, title: "Обществознание", isSelected: false),
        Item(id: 9, title: "География", isSelected: false),
        Item(id: 10, title: "Литература", isSelected: false)
    ]
    
    // MARK: - UIView
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let blueStrip: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.accent
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.title
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "birdie"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 48
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.next, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.isEnabled = false
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = Colors.background
        
        view.addSubview(scrollView)
        view.addSubview(bottomBar)
        scrollView.addSubview(contentView)
        contentView.addSubview(blueStrip)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(tableView)
        bottomBar.addSubview(separatorView)
        bottomBar.addSubview(nextButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableHeight = 10 * (48 + 10) + 20
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            blueStrip.topAnchor.constraint(equalTo: contentView.topAnchor),
            blueStrip.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            blueStrip.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            blueStrip.heightAnchor.constraint(equalToConstant: 16),
            
            iconImageView.topAnchor.constraint(equalTo: blueStrip.bottomAnchor, constant: 16),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(tableHeight)),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 74),
            
            separatorView.topAnchor.constraint(equalTo: bottomBar.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            nextButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 16),
            nextButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    private func updateNextButtonState() {
        let selectedCount = items.filter { $0.isSelected }.count
        nextButton.isEnabled = selectedCount >= 1
        nextButton.backgroundColor = nextButton.isEnabled
        ? Colors.activeButton
        : Colors.disabledButton
    }
    
    @objc private func nextTapped() {
        let selectedItems = items.filter { $0.isSelected }.map { $0.title }
        print("Selected items: \(selectedItems)")
    }
}

// MARK: - extension ViewController

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        let item = items[indexPath.section]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.section].isSelected.toggle()
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        updateNextButtonState()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section < items.count - 1 ? 10 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .white
        return footerView
    }
}
