with (scope('TrackerPlugin', 'App')) {
  route('#github', function() {
    var loading_div = div('Loading...')
    render(

      breadcrumbs(
        a({ href: '#' }, "BountySource"),
        "Github plugins"
      ),
      loading_div
    );

    BountySource.get_tracker_plugins(function(response) {
      if(response.meta.success) {
        var tracker_plugins = response.data;
        render({target: loading_div},
          form({action: bulk_update_tracker_plugins},
            messages(),
            div("Other developers in the same repository may change these settings."),
            tracker_plugins.map(function(plugin) {
              return div(
                fieldset(
                  h3(plugin.tracker.full_name),
                  div(
                    checkbox({name: 'append_bounty_to_title_' + plugin.id, id: 'append_bounty_to_title_' + plugin.id, checked: plugin.append_bounty_to_title}),
                    label({for: 'append_bounty_to_title_' + plugin.id}, "Append bounty amount to issue title"),
                    br(),
                    checkbox({name: 'append_label_to_title_' + plugin.id, id: 'append_label_to_title_' + plugin.id, checked: plugin.append_label_to_title}),
                    label({for: 'append_label_to_title_' + plugin.id}, "Append 'BountySource.com' label to issue title")
                  )
                )
              )
            }),
            fieldset({ 'class': 'no-label', style: 'margin-top: 10px' },
              submit({ 'class': 'green', style: 'width: 200px' }, 'Update plugins')
            )
          )
        )
      } else {
        render({target: loading_div},
          div("Please link your account with Github to use this feature.")
        )
      }
    })
  });

  define('bulk_update_tracker_plugins', function(form_data) {
    clear_message();
    BountySource.bulk_update_tracker_plugins(form_data, function(response) {
      if(response.meta.success) {
        render_message(success_message('Settings updated!'));
      } else {
        render_message(error_message('Error updating settings.'));
      }
    });
  });
}