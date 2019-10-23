//
//  SettingView.swift
//  PokeMaster
//
//  Created by yl on 2019/10/22.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

//class Settings: ObservableObject {
//
//    enum AccountBehavior: CaseIterable{
//        case register, login
//    }
//
//    enum Sorting: CaseIterable{
//        case id, name, color, favorite
//    }
//
//    @Published var accountBehavior = AccountBehavior.login
//    @Published var email = ""
//    @Published var password = ""
//    @Published var verifyPassword = ""
//
//    @Published var showEnglishName = true
//    @Published var sorting = Sorting.id
//    @Published var showFavoriteOnly = false
//}

struct SettingView: View {
    
//    @ObservedObject var settings = Settings()
    
    @EnvironmentObject var store: Store
    
    var settingsBinding: Binding<AppState.Settings>{
        $store.appState.settings
    }
    
    var settings: AppState.Settings{
        store.appState.settings
    }
    
    var body: some View {
        Form{
            accountSection
            optionSection
            actionSection
        }
    }
    
    var accountSection: some View{
        Section(header: Text("账户")) {
            if settings.loginUser == nil{
                Picker(
                    selection: settingsBinding.accountBehavior,
                    label: Text(""))
                {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self){
                        Text($0.text)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                TextField("电子邮箱", text: settingsBinding.email)
                SecureField("密码", text: settingsBinding.password)
                
                if settings.accountBehavior == .register{
                    SecureField("确认密码", text: settingsBinding.verifyPassword)
                }
                
                Button(settings.accountBehavior.text){
                    print("登录/注册")
                    self.store.dispatch(
                        .login(email: self.settings.email, password: self.settings.password)
                    )
                }
            }else{
                Text(settings.loginUser!.email)
                Button("注销"){
                    print("注销")
                }
            }
        }
    }
    
    var optionSection: some View{
        
        Section(header: Text("选项")){
            
            Toggle(isOn: settingsBinding.showEnglishName){
                Text("显示英文名")
            }
            
            Picker(selection: settingsBinding.sorting, label: Text("排序方式")){
                ForEach(AppState.Settings.Sorting.allCases, id: \.self){
                    Text($0.text)
                }
            }
            
            Toggle(isOn: settingsBinding.showFavoriteOnly){
                Text("只显示收藏")
            }
        }
}
    
    var actionSection: some View{
        Section{
            Button(action:{
                print("清空缓存")
            }){
                Text("清空缓存").foregroundColor(.red)
            }
        }
    }
}


extension AppState.Settings.Sorting{
    var text: String{
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
}

extension AppState.Settings.AccountBehavior{
    var text: String{
        switch self{
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
