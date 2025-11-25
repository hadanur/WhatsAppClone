//
//  AppScreen.swift
//  WhatsAppClone
//
//  Created by Hakan Adanur on 20/11/2025.
//

import SwiftUI

enum AppStatus {
    case loading
    case unauthenticated
    case authenticated
}

enum AppRoute: Hashable {
    case register
    case auth
    case main
}
