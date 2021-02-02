//
//  UserSearchView.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import SwiftUI

protocol UserSearchViewDelegate: AnyObject {
    func userSearchView(didSearchFor name: String)
    func openDebugSettings()
}

final class UserSearchViewModel {
    let suggestedUsernames: [String] = [
        "withprimer",
        "loloop",
        "CocoaHeadsConference",
        "Apple"
    ]
}

struct UserSearchView: View {

    @State private var currentTextFieldInput: String = ""
    let viewModel: UserSearchViewModel
    weak var delegate: UserSearchViewDelegate?

    var body: some View {
        List {
            searchField
            suggestedUsernames
            #if DEBUG
            debugSettingsButton
            #endif
        }
        .listStyle(InsetGroupedListStyle())
    }

    var searchField: some View {
        VStack {
            TextField("Search for username", text: $currentTextFieldInput,
                      onEditingChanged: { _ in },
                      onCommit: {
                        self.search(for: currentTextFieldInput)
                      })
                .padding()
                .keyboardType(.webSearch)
        }
    }

    var suggestedUsernames: some View {
        Section(header: Text("Suggested Usernames")) {
            ForEach(viewModel.suggestedUsernames, id: \.self) { username in
                Button(action: {
                    self.search(for: username)
                }, label: {
                    HStack {
                        Text(username)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                })
            }
        }
    }

    var debugSettingsButton: some View {
        Section {
            Button(action: {
                self.presentDebugSettings()
            }, label: {
                HStack {
                    Text("Open Debug Settings")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            })
        }
    }

    func search(for name: String) {
        guard name.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }
        delegate?.userSearchView(didSearchFor: name)
    }

    func presentDebugSettings() {
        #if DEBUG
        delegate?.openDebugSettings()
        #endif
    }
}

struct UserSearchView_Previews: PreviewProvider {

    class Delegate: UserSearchViewDelegate {
        func openDebugSettings() {}

        func userSearchView(didSearchFor name: String) {}
    }

    static var previews: some View {
        UserSearchView(viewModel: UserSearchViewModel())
    }
}
