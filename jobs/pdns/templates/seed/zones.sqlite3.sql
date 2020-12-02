<% p('zones').each_with_index do |zone, domain_id| %>
INSERT INTO domains (name, type) values ('<%= zone.fetch('name') %>', 'NATIVE');

  <% zone.fetch('records').each do |record| %>
INSERT INTO records (domain_id, name, content, type,ttl,prio)
VALUES (
    <%= domain_id + 1 %>,
    '<%= record.fetch('name') %>',
    '<%= record.fetch('content') %>',
    '<%= record.fetch('type') %>',
    <%= record.fetch('ttl') %>,
    NULL
);
    <% end %>
<% end %>