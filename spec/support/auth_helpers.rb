module AuthHelpers
    def request_log_in(username:, password:)
        post login_path, params: { username:, password: }
        follow_redirect! if respond_to?(:follow_redirect!)
    end
end