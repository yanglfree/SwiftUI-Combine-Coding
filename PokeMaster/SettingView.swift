//
//  SettingView.swift
//  PokeMaster
//
//  Created by yl on 2020/12/17.
//  Copyright © 2020 Liang. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var settings = Settings()
    
    var accountSection: some View {
        Section(header: Text("账户")){
            Picker(selection: $settings.accountBehavior, label: Text("")) {
                ForEach(Settings.AccountBehavior.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            TextField("电子邮箱", text: $settings.email)
            SecureField("密码", text: $settings.password)
            
            if settings.accountBehavior == .register {
                SecureField("确认密码", text: $settings.verifyPassword)
            }
            
            Button(settings.accountBehavior.text) {
                print("登录/注册")
            }
        }
    }
    
    var optionSection: some View {
        Section(header: Text("选项")){
            HStack{
                Text("显示英文名")
                Spacer()
                Toggle("", isOn: $settings.showEnglishName)
            }
            
            Picker(selection: $settings.sorting, label: Text("排序方式"), content: {
                ForEach(Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            })
            .pickerStyle(DefaultPickerStyle())
            
            HStack{
                Text("只显示收藏")
                Spacer()
                Toggle("", isOn: $settings.showFavoriteOnly)
            }
        }
    }
    
    var actionSection: some View {
        Section{
            Text("清空缓存")
                .foregroundColor(.red)
        }
    }
    
    var body: some View {
        Form {
            accountSection
            optionSection
            actionSection
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
