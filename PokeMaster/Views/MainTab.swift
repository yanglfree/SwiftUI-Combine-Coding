//
//  MainTab.swift
//  PokeMaster
//
//  Created by yl on 2020/12/26.
//  Copyright © 2020 Liang. All rights reserved.
//

import SwiftUI

struct MainTab: View {
    var body: some View {
        
        TabView {
            PokemonListRootView().tabItem {
                Image(systemName: "list.bullet.below.rectangle")
                Text("列表")
            }
            
            SettingRootView().tabItem {
                Image(systemName: "gear")
                Text("设置")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}
