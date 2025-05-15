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
        return delete
    }()
    
    let bookCart: UILabel = {
        let cart = UILabel()
        cart.text = "담은 책"
        cart.font = .systemFont(ofSize: 15, weight: .bold)
        return cart
    }()
    
    let addButton: UIButton = {
        let add = UIButton()
        add.setTitle("추가", for: .normal)
        add.setTitleColor(.black, for: .normal)
        add.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        return add
    }()
    
    let table = UITableView()
    var data = [BookData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        [deleteBtn, bookCart, addButton, table].forEach({ view.addSubview($0)})
        
        table.delegate = self
        table.dataSource = self
        table.register(AddCell.self, forCellReuseIdentifier: AddCell.id)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        bookCart.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().inset(10)
        }
        
        bookCart.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        table.snp.makeConstraints {
            $0.top.equalTo(bookCart.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    @objc func addBtnTapped() {
        let goBackTo = BookViewController()
        navigationController?.pushViewController(goBackTo, animated: true)
    }
    
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    
}
