with (scope('JSONP')) {

  initializer(function() {
    scope.jsonp_mock_responses = {};
    scope.jsonp_callback_sequence = 0;
    scope.jsonp_callbacks = {};
  });

  // usage: JSONP.get({ url: ..., method: ..., callback: ..., params: ... });
  define('get', function(options) {
    var response = scope.jsonp_mock_responses[options.response_key];
    options.callback.call(null, response);
  });
}

with (scope('BountySource')) {
  define('_original_api', api);
  // parse arguments: url, [http_method], [params], [callback]
  define('api', function() {
    var args = Array.prototype.slice.call(arguments);
    var url = args.shift();
    var options = {
      url:       api_host + url.replace(/^\//,''),
      method:    typeof(args[0]) == 'string' ? args.shift() : 'GET',
      params:    typeof(args[0]) == 'object' ? args.shift() : {},
      callback:  typeof(args[0]) == 'function' ? args.shift() : function(){},
      non_auth_callback:  typeof(args[0]) == 'function' ? args.shift() : null,
      response_key: url
    };

    // add in our access token
    options.params.access_token = Storage.get('access_token');

    // reload the page if they're not authorized
    var callback = options.callback;
    options.callback = function(response) {
      if (response && response.meta && parseInt(response.meta.status) == 401) {
        Storage.remove('access_token');
        if (options.non_auth_callback) options.non_auth_callback(response);
        else if (scope.instance.App.unauthorized_callback) scope.instance.App.unauthorized_callback(options);
        else set_route('#');
      } else {
        // turn error message into string, or use default
        if (!response.meta.success) {
          if (!response.data.error) {
            response.data.error = "Unexpected error";
          } else if (response.data.error.push) {
            response.data.error = response.data.error.join(', ');
          }
        }

        callback.call(this, response);
      }
    };

    JSONP.get(options);
  });

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
        fundraisers: [
          {
            card_id: "f8",
            created_at: "2013-03-01T02:35:26Z",
            featured: true,
            frontend_path: "#fundraisers/8-qa-fr",
            funding_goal: 20000,
            id: 8,
            image_url: "",
            published: true,
            short_description: "This is the basic info",
            title: "QA FR",
            total_pledged: "10.0",
          }
        ],
        issues: [
          {
            author_image_url: "https://secure.gravatar.com/avatar/bdeaea505d059ccf23d8de5714ae7f73?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
            author_name: "corytheboyd",
            bounty_total: "0.0",
            can_add_bounty: true,
            card_id: "i8",
            comment_count: 1,
            created_at: "2012-12-19T18:40:19Z",
            featured: false,
            frontend_path: "#issues/8-test-issue-omg",
            id: 8,
            number: 18,
            short_body: "fdsa",
            slug: "8-test-issue-omg",
            title: "test! issue! omg!",
            tracker: {
              bounty_total: "0.0",
              description: "This is a test repository, please politely ignore it.",
              featured: false,
              forks: 3,
              frontend_path: "#trackers/4-coryboyd-bs-test",
              frontend_url: "http://www.bountysource.dev/#trackers/4-coryboyd-bs-test",
              id: 4,
              image_url: "https://secure.gravatar.com/avatar/de5ddecd975db4d548ebac94210423ff?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
              languages: [
                {
                  bytes: 61,
                  name: "JavaScript"
                }
              ],
              name: "Coryboyd Bs-Test",
              slug: "4-coryboyd-bs-test",
              url: "https://github.com/coryboyd/bs-test",
              watchers: 0
            },
            url: "https://github.com/coryboyd/bs-test/issues/18"
          }
        ]
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