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
  fundraiser: {
    about_me: nil,
    created_at: "2013-03-01T02:35:26Z",
    days_open: 90,
    days_remaining: 86,
    description_html: "<p>This is the description</p>",
    featured: true,
    frontend_path: "#fundraisers/8-qa-fr",
    frontend_url: "http://www.bountysource.dev/#fundraisers/8-qa-fr",
    funding_goal: 20000,
    homepage_url: "",
    id: 8,
    image_url: "",
    max_days_open: 180,
    max_end_by_date: "2013-09-07T23:59:59+07:00",
    min_days_open: 30,
    min_end_by_date: "2013-04-10T00:00:00+07:00",
    payout_method: "on_funding",
    person: {
      created_at: "2013-02-28T07:31:34Z",
      display_name: "bountysource-qa",
      first_name: "John",
      frontend_path: "#users/5-bountysource-qa",
      id: 5,
      image_url: "https://secure.gravatar.com/avatar/be17917983af5418067b533643341954?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
      last_name: "Doe",
      slug: "5-bountysource-qa",
    },
    pledges: [
      {
        amount: "10.0",
        created_at: "2013-03-01T04:08:18Z",
        id: 4
      }
    ],
    publishable: false,
    published: true,
    repo_url: nil,
    rewards: [
      {
        amount: 10,
        claimed: 1,
        created_at: "2013-03-01T02:36:14Z",
        delivered_at: nil,
        description: "You will have a voucher",
        fulfillment_details: "You will have a voucher with detailed info",
        fundraiser_id: 8,
        id: 15,
        limited_to: 10,
        sold_out: false,
        timezone: nil,
        updated_at: "2013-03-01T04:08:18Z",
        vanity_url: nil
      }
    ],
    short_description: "This is the basic info",
    title: "QA FR",
    total_pledged: "10.0",
  },
  pledge: {
    amount: "10.0",
    created_at: "2013-03-01T04:08:18Z",
    fundraiser: {
      created_at: "2013-03-01T02:35:26Z",
      featured: true,
      frontend_path: "#fundraisers/8-qa-fr",
      funding_goal: 20000,
      id: 8,
      image_url: "",
      published: true,
      short_description: "This is the basic info",
      title: "QA FR",
      total_pledged: "10.0"
    },
    id: 4,
    reward: {
      amount: 10,
      claimed: 1,
      created_at: "2013-03-01T02:36:14Z",
      delivered_at: nil,
      description: "You will have a voucher",
      fulfillment_details: "You will have a voucher with detailed info",
      fundraiser_id: 8,
      id: 15,
      limited_to: 10,
      sold_out: false,
      timezone: nil,
      updated_at: "2013-03-01T04:08:18Z",
      vanity_url: nil
    },
  },
  issue: {
    author_image_url: "https://secure.gravatar.com/avatar/bdeaea505d059ccf23d8de5714ae7f73?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
    author_name: "corytheboyd",
    body_html: "<p>fdsa</p>",
    bounties: [],
    bounty_total: "0.0",
    can_add_bounty: true,
    comment_count: 1,
    comments: [],
    created_at: "2012-12-19T18:40:19Z",
    featured: false,
    frontend_path: "#issues/8-test-issue-omg",
    id: 8,
    number: 18,
    short_body: "fdsa",
    slug: "8-test-issue-omg",
    solutions: [],
    title: "test! issue! omg!",
    tracker: {
      frontend_path: "#trackers/4-coryboyd-bs-test",
      id: 4,
      image_url: "https://secure.gravatar.com/avatar/de5ddecd975db4d548ebac94210423ff?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
      name: "Coryboyd Bs-Test",
      slug: "4-coryboyd-bs-test"
    },
    url: "https://github.com/coryboyd/bs-test/issues/18"
  },
  bounty: {
    amount: "1.0",
    created_at: "2013-03-11T07:51:49Z",
    expires_at: nil,
    id: 2,
    issue: {
      author_image_url: "https://secure.gravatar.com/avatar/bdeaea505d059ccf23d8de5714ae7f73?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
      author_name: "corytheboyd",
      body_html: "<p>fdsa</p>",
      bounties: [],
      bounty_total: "0.0",
      can_add_bounty: true,
      comment_count: 1,
      comments: [],
      created_at: "2012-12-19T18:40:19Z",
      featured: false,
      frontend_path: "#issues/8-test-issue-omg",
      id: 8,
      number: 18,
      short_body: "fdsa",
      slug: "8-test-issue-omg",
      solutions: [],
      title: "test! issue! omg!",
      tracker: {
        frontend_path: "#trackers/4-coryboyd-bs-test",
        id: 4,
        image_url: "https://secure.gravatar.com/avatar/de5ddecd975db4d548ebac94210423ff?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
        name: "Coryboyd Bs-Test",
        slug: "4-coryboyd-bs-test"
      },
      url: "https://github.com/coryboyd/bs-test/issues/18"
    }
  },
  bounties: {
    backers: {
      most_issues_backed: [
        {
          display_name: "Bob",
        }
      ],
      most_total_bounties: [
        {
          created_at: "2013-02-19T05:07:09Z",
          display_name: "john.doe",
          first_name: "John",
          frontend_path: "#users/1-john-doe",
          id: 1,
          image_url: "https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-user-420.png",
          last_name: "Doe",
          slug: "1-john-doe"
        }
      ]
    },
    distinct_backers_count: 2,
    fundraisers: {},
    issues: {
      featured: [],
      largest_bounties: [
        {
          author_image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
          author_name: "thailehuy",
          bounty_total: "25.0",
          can_add_bounty: true,
          comment_count: 0,
          created_at: "2013-02-21T04:40:50Z",
          featured: false,
          frontend_path: "#issues/7-testing",
          id: 7,
          number: 1,
          short_body: "Issue testing",
          slug: "7-testing",
          title: "Testing",
          tracker: {
            bounty_total: "25.0",
            description: "This is the place to fetch blog post and display them",
            featured: false,
            forks: 0,
            frontend_path: "#trackers/3-thailehuy-hblog",
            frontend_url: "http://www.bountysource.dev/#trackers/3-thailehuy-hblog",
            id: 3,
            image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
            languages: [],
            name: "Thailehuy Hblog",
            slug: "3-thailehuy-hblog",
            url: "https://github.com/thailehuy/hblog",
            watchers: 0
          },
          url: "https://github.com/thailehuy/hblog/issues/1"
        }
      ],
      newest: [
        {
          author_image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
          author_name: "thailehuy",
          bounty_total: "25.0",
          can_add_bounty: true,
          comment_count: 0,
          created_at: "2013-02-21T04:40:50Z",
          featured: false,
          frontend_path: "#issues/7-testing",
          id: 7,
          number: 1,
          short_body: "Issue testing",
          slug: "7-testing",
          title: "Testing",
          tracker: {
            bounty_total: "25.0",
            description: "This is the place to fetch blog post and display them",
            featured: false,
            forks: 0,
            frontend_path: "#trackers/3-thailehuy-hblog",
            frontend_url: "http://www.bountysource.dev/#trackers/3-thailehuy-hblog",
            id: 3,
            image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
            languages: [],
            name: "Thailehuy Hblog",
            slug: "3-thailehuy-hblog",
            url: "https://github.com/thailehuy/hblog",
            watchers: 0
          },
          url: "https://github.com/thailehuy/hblog/issues/1"
        }
      ],
      popular: [
        {
          author_image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
          author_name: "thailehuy",
          bounty_total: "25.0",
          can_add_bounty: true,
          comment_count: 0,
          created_at: "2013-02-21T04:40:50Z",
          featured: false,
          frontend_path: "#issues/7-testing",
          id: 7,
          number: 1,
          short_body: "Issue testing",
          slug: "7-testing",
          title: "Testing",
          tracker: {
            bounty_total: "25.0",
            description: "This is the place to fetch blog post and display them",
            featured: false,
            forks: 0,
            frontend_path: "#trackers/3-thailehuy-hblog",
            frontend_url: "http://www.bountysource.dev/#trackers/3-thailehuy-hblog",
            id: 3,
            image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
            languages: [],
            name: "Thailehuy Hblog",
            slug: "3-thailehuy-hblog",
            url: "https://github.com/thailehuy/hblog",
            watchers: 0
          },
          url: "https://github.com/thailehuy/hblog/issues/1"
        }
      ]
    },
    largest_unclaimed: {},
    most_bounteous_issue_total: 25,
    projects: {},
    total_active_bounties: 2,
    total_active_issues: 2,
    total_bounties_created_this_month: 1,
    total_paid_last_month: 0,
    total_paid_this_month: 0,
    total_paid_to_date: 0,
    total_unclaimed: 26
  },
  tracker: {
    bounty_total: "1.0",
    description: "This is a test repository, please politely ignore it.",
    featured: false,
    forks: 3,
    frontend_path: "#trackers/4-coryboyd-bs-test",
    frontend_url: "http://www.bountysource.dev/#trackers/4-coryboyd-bs-test",
    id: 4,
    image_url: "https://secure.gravatar.com/avatar/de5ddecd975db4d548ebac94210423ff?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
    issues_featured: [],
    issues_newest: [],
    issues_popular: [],
    issues_valuable: [],
    languages: [],
    name: "Coryboyd Bs-Test",
    slug: "4-coryboyd-bs-test",
    url: "https://github.com/coryboyd/bs-test",
    watchers: 0
  },
  solution: {
    accepted: false,
    accepted_at: nil,
    body: nil,
    code_url: nil,
    created_at: "2013-03-12T03:19:36Z",
    dispute_period_end_date: nil,
    frontend_path: "#solutions/4",
    frontend_url: "http://www.bountysource.dev/#solutions/4",
    id: 4,
    issue: {
      author_image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
      author_name: "thailehuy",
      bounty_total: "25.0",
      can_add_bounty: true,
      comment_count: 0,
      created_at: "2013-02-21T04:40:50Z",
      featured: false,
      frontend_path: "#issues/7-testing",
      id: 7,
      number: 1,
      short_body: "Issue testing",
      slug: "7-testing",
      title: "Testing",
      tracker: {
        bounty_total: "25.0",
        description: "This is the place to fetch blog post and display them",
        featured: false,
        forks: 0,
        frontend_path: "#trackers/3-thailehuy-hblog",
        frontend_url: "http://www.bountysource.dev/#trackers/3-thailehuy-hblog",
        id: 3,
        image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
        languages: [],
        name: "Thailehuy Hblog",
        slug: "3-thailehuy-hblog",
        url: "https://github.com/thailehuy/hblog",
        watchers: 0
      },
      url: "https://github.com/thailehuy/hblog/issues/1"
    },
    paid_out: false,
    person: {
      created_at: "2013-03-01T04:05:07Z",
      display_name: "thailehuy",
      first_name: "HuyT",
      frontend_path: "#users/9-thailehuy",
      id: 9,
      image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
      last_name: "HuyT",
      slug: "9-thailehuy"
    },
    submitted: false,
    submitted_at: nil,
    updated_at: "2013-03-12T03:19:36Z"
  },
  submitted_solution: {
    parent: :solution,
    in_dispute_period: true,
    disputed: false,
    submitted: true
  },
  accepted_solution: {
    parent: :solution,
    submitted: true,
    accepted: true
  },
  disputed_solution: {
    parent: :solution,
    submitted: true,
    accepted: true,
    disputed: true
  },
  solutions: [
    {
      accepted: false,
      accepted_at: nil,
      body: nil,
      code_url: nil,
      created_at: "2013-03-12T03:19:36Z",
      dispute_period_end_date: nil,
      frontend_path: "#solutions/4",
      frontend_url: "http://www.bountysource.dev/#solutions/4",
      id: 4,
      issue: {
        author_image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
        author_name: "thailehuy",
        bounty_total: "25.0",
        can_add_bounty: true,
        comment_count: 0,
        created_at: "2013-02-21T04:40:50Z",
        featured: false,
        frontend_path: "#issues/7-testing",
        id: 7,
        number: 1,
        short_body: "Issue testing",
        slug: "7-testing",
        title: "Testing",
        tracker: {
          bounty_total: "25.0",
          description: "This is the place to fetch blog post and display them",
          featured: false,
          forks: 0,
          frontend_path: "#trackers/3-thailehuy-hblog",
          frontend_url: "http://www.bountysource.dev/#trackers/3-thailehuy-hblog",
          id: 3,
          image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
          languages: [],
          name: "Thailehuy Hblog",
          slug: "3-thailehuy-hblog",
          url: "https://github.com/thailehuy/hblog",
          watchers: 0
        },
        url: "https://github.com/thailehuy/hblog/issues/1"
      },
      paid_out: false,
      person: {
        created_at: "2013-03-01T04:05:07Z",
        display_name: "thailehuy",
        first_name: "HuyT",
        frontend_path: "#users/9-thailehuy",
        id: 9,
        image_url: "https://secure.gravatar.com/avatar/89f133b618e8530d78bf1dc59c5f7dd3?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
        last_name: "HuyT",
        slug: "9-thailehuy"
      },
      submitted: false,
      submitted_at: nil,
      updated_at: "2013-03-12T03:19:36Z",
    }
  ]
}

def factory(model, count = 1)
  result = count.times.map do |i|
    attrs = FACTORIES[model.to_sym]
    if attrs.is_a?(Hash)
      attrs.merge!(id: attrs[:id] + count - 1) if attrs[:id]
      parent = attrs[:parent]

      attrs = factory(parent).merge(attrs) if parent
    end
    attrs
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