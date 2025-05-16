//
//  AddViewContoller.swift
//  BookStore_project
//
//  Created by Sophie on 5/11/25.
//

import UIKit
import SnapKit

class AddViewController: UIViewController {
    
    let deleteBtn: UIButton = {
        let delete = UIButton()
        delete.setTitle("전체 삭제", for: .normal)
        delete.setTitleColor(.lightGray, for: .normal)
        delete.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        return delete
    }()
    
    let savedBook: UILabel = {
        let cart = UILabel()
        cart.text = "담은 책"
        cart.font = .systemFont(ofSize: 22, weight: .bold)
        return cart
    }()
    
    let addButton: UIButton = {
        let add = UIButton()
        add.setTitle("추가", for: .normal)
        add.setTitleColor(.systemGreen, for: .normal)
        add.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        return add
    }()
    
    
    let table = UITableView(frame: .zero, style: .grouped)
    var data = [BookData]()
    
    weak var delegate: AddViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        [deleteBtn, savedBook, addButton, table].forEach({ view.addSubview($0)})
        
        table.delegate = self
        table.dataSource = self
        table.register(AddCell.self, forCellReuseIdentifier: AddCell.id)
//        table.contentInset = .init(top: 20, left: 10, bottom: 20, right: 10)
        table.backgroundColor = .white
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        data = BookCartManager.savedBooks2
        table.reloadData()
    }
    
    func setConstraints() {
        
        savedBook.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-20)
            $0.centerX.equalToSuperview()
            
        }
        
        deleteBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-20)
            $0.centerY.equalTo(savedBook.snp.centerY)
            $0.leading.equalToSuperview().inset(30)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-20)
            $0.centerY.equalTo(savedBook.snp.centerY)
            $0.trailing.equalToSuperview().inset(31)
        }
        
        table.snp.makeConstraints {
            $0.top.equalTo(savedBook.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    @objc func addBtnTapped() {
        let goBackTo = BookViewController()
        navigationController?.pushViewController(goBackTo, animated: true)
    }
    
    @objc func deleteTapped() {
        data.removeAll()
        table.reloadData()
    }
    
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddCell.id, for: indexPath) as? AddCell else { return.init() }
        
        let row = indexPath.row
        let datas = data[row]
        
        cell.configure(data: datas)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    

}
