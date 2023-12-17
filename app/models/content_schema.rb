# frozen_string_literal: true

class ContentSchema < ActiveRecord::Base
  self.abstract_class = true
  establish_connection adapter: 'postgresql',
                       encoding: 'utf-8',
                       database: 'nordstream-db-fi',
                       host: 'sordstream-fi.postgres.database.azure.com',
                       port: 5432,
                       username: 'disadmindis',
                       password: 'HugGuy#7',
                       schema_search_path: 'content'
end
