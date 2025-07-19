//
//  TravelTalkViewController.swift
//  ChattingApp
//
//  Created by YoungJin on 7/18/25.
//

import UIKit

final class TravelTalkViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    private var chatRoomList: [ChatRoom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        setUpNaviBar()
        setUpData()
        setUpCollectionView()
    }
    
    private func setUpNaviBar() {
        title = Text.travelTalkTitle
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.configureWithOpaqueBackground() // 불투명
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance // 기본설정
        navigationController?.navigationBar.compactAppearance = appearance // 컴팩트바 ?
        navigationController?.navigationBar.scrollEdgeAppearance = appearance // 스크롤 시
    }
    
    private func setUpCollectionView() {
        collectionView.register(CellType.travelTalk.nib, forCellWithReuseIdentifier: CellType.travelTalk.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 0 // 셀과 셀 사이
        layout.minimumLineSpacing = 0 // 위 아래 간격
        
        let cellWidth = UIScreen.main.bounds.width - 32
        layout.itemSize = .init(width: cellWidth, height: 68)
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setUpData() {
        chatRoomList = ChatList.list
    }
}

extension TravelTalkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatRoomList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.travelTalk.id, for: indexPath) as! TravelTalkCell
        
        cell.chatRoom = chatRoomList[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: Storyboard.chattingVC) as! ChattingViewController
        
        vc.chatList = chatRoomList[indexPath.item].chatList
        vc.title = chatRoomList[indexPath.item].chatroomName
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
