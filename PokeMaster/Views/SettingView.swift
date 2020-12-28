//
//  SettingView.swift
//  PokeMaster
//
//  Created by yl on 2020/12/17.
//  Copyright © 2020 Liang. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var store: Store
        
    var settingBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var accountSection: some View {
        Section(header: Text("账户")){
            
            if settings.loginUser == nil {
            
                Picker("", selection: settingBinding.checker.accountBehavior, content: {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                })
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("电子邮箱", text: settingBinding.checker.email)
                    .foregroundColor(settings.isEmailValid ? .green : .red)
                SecureField("密码", text: settingBinding.checker.password)
                
                if settings.checker.accountBehavior == .register {
                    SecureField("确认密码", text: settingBinding.checker.verifyPassword)
                }
                if settings.loginRequesting {
//                    Text("登录中...")
                    YLActivityIndicatorView()
                    
                } else {
                    Button(settings.checker.accountBehavior.text) {
                        print("登录/注册")
                        self.store.dispatch(.login(email: self.settings.checker.email, password: self.settings.checker.password))
                    }
                }
            } else {
                Text(settings.loginUser!.email)
                Button("注销") {
                    self.store.dispatch(.logout)
                }
            }
        }
    }
    
    var optionSection: some View {
        Section(header: Text("选项")){
            HStack{
                Text("显示英文名")
                Spacer()
                Toggle("", isOn: settingBinding.showEnglishName)
            }
            
            Picker(selection: settingBinding.sorting, label: Text("排序方式"), content: {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            })
            .pickerStyle(DefaultPickerStyle())
            
            HStack{
                Text("只显示收藏")
                Spacer()
                Toggle("", isOn: settingBinding.showFavoriteOnly)
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
        .alert(item: settingBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
    }
}

extension AppState.Settings.Sorting {
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
}

extension AppState.Settings.AccountBehavior {
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
