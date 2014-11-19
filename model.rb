class User
  include DataMapper::Resource
  property :id, Serial
  property :nickname, Text
end

