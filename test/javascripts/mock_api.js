with (scope('BountySource')) {
  define('_original_api', api);
  define('api', function() { console.log('API CALLED', arguments) });
  define('user_info', function(callback) {
    var response = {
      data: {
        id: 1,
        to_param: "1-tester",
        first_name: "John",
        last_name: "Doe",
        display_name: "john.doe",
        frontend_path: "#users/1-tester",
        avatar_url: 'https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-user-420.png',
        created_at: new Date(),
        email: "john.doe@example.com",
        access_token: "secret_access_token",
        account: {
          balance: 0.0
        },
      password: "123456"
      },
      meta: {success: true, status: 200}
    }
    callback(response)
  });

  define('basic_user_info', function(callback) {
    var response = {
      data: {
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
      meta: {success: true, status: 200}
    }
    callback(response)
  });

  define('get_more_cards', function(ignore, query, callback) {
    var response = {
      data: {
        fundraisers: [],
        issues: []
      },
      meta: {success: true, status: 200}
    }
    callback(response)
  });

  define('recent_people', function(callback) {
    var response = {
      data: {
        people: [],
        total_count: 0
      },
      meta: {success: true, status: 200}
    }
    callback(response)
  });
}