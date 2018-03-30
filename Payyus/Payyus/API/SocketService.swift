//
//  SocketService.swift
//  Payyus
//
//  Created by Thuỳ Nguyễn on 3/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SocketRocket
protocol PaymentDelegate: NSObjectProtocol {
    func onConnected()
    func onReceiveCnum(cnum: String)
    func onPaymentConfirmationRequest(message: String)
}

class SocketService: NSObject {
    private var socket: SRWebSocket

    var onConnected: ((SocketService)->Void)?

    override init() {
        let url = AppConfiguration.shared.socketURL()
//        let url = "ws://ach.payyus.com/:8080"
        socket = SRWebSocket(url: URL(string: url)!)
        super.init()
        socket.delegate = self
        socket.open()

    }
    func disconnect()  {
        socket.close(withCode: 1, reason: "Cancel payment!")
    }

    func anyCnumResp(phone: String){
        let params = ["message-type": "any_cnum", "userName": phone]
        socket.send(params)
    }

    func shopperPayConfirm(cardData: BankAccount) {
        let params = cardData.toDictionary()
        params.setValue("shopper_pay_confirm", forKey: "message-type")
        socket.send(params)
    }

    func shopperPayCancel() {
        let params = ["message-type":"shopper_pay_cancel"]
        socket.send(params)
    }

    func shopperReloadConfirm(params: NSDictionary) {
//        let params = reloadInfo as NSDictionary
        params.setValue("shopper_reload_confirm", forKey: "message-type")
        params.setValue("v3", forKey: "v")
        socket.send(params.toJsonString())
    }
}

extension SocketService: SRWebSocketDelegate {
    enum SocketMessageType : String {
        case error = "error"
        case anyCnumResp = "any_cnum_resp"
        case pleaseConfirmSenttoShopper = "please_confirm_sentto_shopper"
        case paymentResultSenttoShopper = "payment_result_sentto_shopper"

    }
    func webSocketDidOpen(_ webSocket: SRWebSocket!) {
        print("socket connected")
        onConnected?(self)
//        socket.send("Hello")
    }
    func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
        print("socket message: \(message)")
        let socketMessage = SocketMessage(json: message as? String)
        if let messageType = SocketMessageType(rawValue: socketMessage.messageType) {
            switch messageType {
            case .anyCnumResp:
                break

            default:
                print(socketMessage.details)
            }
        }

    }

    func webSocket(_ webSocket: SRWebSocket!, didFailWithError error: Error!) {
        print(error.localizedDescription)
    }
    
}
