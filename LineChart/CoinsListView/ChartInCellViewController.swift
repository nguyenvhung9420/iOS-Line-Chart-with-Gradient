//
//  ChartInCellViewController.swift
//  LineChart
//
//  Created by Hung Nguyen on 23/10/2021.
//  Copyright © 2021 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit
import Starscream

class ChartInCellViewController: UIViewController {

    @IBOutlet weak var coinsTableVIew: UITableView!
    
    private var socket: WebSocket!
    private var isConnected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initWebsocket()
        
        coinsTableVIew.delegate = self
        coinsTableVIew.dataSource = self
        
        coinsTableVIew.register(UINib(nibName: "WithChartTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    
    private func initWebsocket() {
        var request = URLRequest(url: URL(string: "wss://demo-broadcast-websocket-js.herokuapp.com")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
}


extension ChartInCellViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WithChartTableViewCell
        cell.configCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

 
extension ChartInCellViewController: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error?) {
        print(error?.localizedDescription ?? "error")
    }
}

