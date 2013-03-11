FACTORIES = {
  user: {
      id: 1,
      to_param: "1-tester",
      first_name: "John",
      last_name: "Doe",
      display_name: "john.doe",
      frontend_path: "#users/1-tester",
      avatar_url: 'https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-user-420.png',
      created_at: Time.now,
      email: "john.doe@example.com",
      access_token: "secret_access_token",
      password: "123456"
  },
  registered_user: {
    parent: :user,
    email_is_registered: true
  },
  unregistered_user: {
    parent: :user,
    email_is_registered: false
  },
  cards: {
    fundraisers: [],
    issues: []
  }
}

def factory(model, count = 1)
  result = count.times.map do |i|
    attrs = FACTORIES[model.to_sym]
    attrs.merge!(id: attrs[:id] + count - 1) if attrs[:id]
    if attrs[:parent]
      attrs.merge!(factory(attrs[:parent]))
    else
      attrs
    end
  end

  count == 1 ? result.first : result
end

def mock_options(model, opts = {})
  {
    success: opts[:success].nil? ? true : opts[:success],
    status: opts[:status] || 200,
    data: factory(model, opts[:count] || 1)
  }
end