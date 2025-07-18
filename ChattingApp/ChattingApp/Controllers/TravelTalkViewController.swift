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
        title = "TRAVEL TALK"
        setUpData()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "TravelTalkCell", bundle: nil), forCellWithReuseIdentifier: "TravelTalkCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TravelTalkCell", for: indexPath) as! TravelTalkCell
        
        cell.chatRoom = chatRoomList[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ChattingViewController") as! ChattingViewController
        
        vc.chatList = chatRoomList[indexPath.item].chatList
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
