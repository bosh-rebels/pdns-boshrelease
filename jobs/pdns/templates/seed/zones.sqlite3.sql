<% p('zones').each_with_index do |zone, domain_id| %>
INSERT INTO domains (name, type) values ('<%= zone.fetch('name') %>', 'NATIVE');
INSERT INTO records (domain_id, name, content, type,ttl,prio)
VALUES (
    <%= domain_id + 1 %>,
    '<%= zone.fetch('name') %>',
    'localhost admin.<%= zone.fetch('name')%> 1 10380 3600 604800 3600',
    'SOA',
    86400,
    NULL
);
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