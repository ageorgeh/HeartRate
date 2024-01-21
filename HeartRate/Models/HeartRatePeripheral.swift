//
//  HeartRatePeripheral.swift
//  HeartRate
//
//  Created by Alexander Hornung on 21/1/2024.
//


import Foundation
import CoreBluetooth


class HeartRatePeripheral: NSObject {
    
    public static let heartRateServiceUUID = CBUUID(string: "0x180D")
    public static let heartRateMesurementCharacteristicUUID = CBUUID(string: "0x2A37")
}

