class CustomFailure < Devise::FailureApp
  protected
    def http_auth_body
      return i18n_message unless request_format
      method = "to_#{request_format}"
      if method == "to_json"
        { :status => :error, :message => i18n_message }.to_json
      elsif {}.respond_to?(method)
        { :error => i18n_message }.send(method)
      else
        i18n_message
      end
    end
end
