module SystemHelpers
    def system_log_in(user, password: "123")
        visit login_path
        fill_in "Username",	with: user.username
        fill_in "Password",	with: password
        click_button "Login"  
    end

    def system_register(user, password: "123")
        visit register_path
        fill_in "Username", with: user
        fill_in "Password", with: password
        fill_in "Password confirmation", with: password
        click_button "Create User"
    end
end