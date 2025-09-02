module SystemHelpers
    def system_log_in(user, password: "123")
        visit login_path
        fill_in "Username",	with: user.username
        fill_in "Password",	with: password
        click_button "Login"  
    end
end