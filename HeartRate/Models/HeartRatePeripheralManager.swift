//
//  HeartRatePeripheralManager.swift
//  HeartRate
//
//  Created by Alexander Hornung on 22/1/2024.
//

import Foundation
import CoreBluetooth

class HeartRatePeripheralManager: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    private var measurementCharactaristic: CBCharacteristic!
    private var heartRateMeasurement: HeartRateMeasurement!
    var isSubscribed = false
    
    
    
    
    init(heartRateMeasurement: HeartRateMeasurement) {
        super.init()
        self.heartRateMeasurement = heartRateMeasurement
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update")
        if central.state != .poweredOn {
            print("Central is not powered on")
        } else {
            print("Central scanning for", HeartRatePeripheral.heartRateServiceUUID);
            centralManager.scanForPeripherals(withServices: [HeartRatePeripheral.heartRateServiceUUID],
                                              options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // We've found it so stop scan
        self.centralManager.stopScan()
        
        // Copy the peripheral instance
        self.peripheral = peripheral
        self.peripheral.delegate = self
        
        // Connect!
        self.centralManager.connect(self.peripheral, options: nil)
        
    }
    
}
