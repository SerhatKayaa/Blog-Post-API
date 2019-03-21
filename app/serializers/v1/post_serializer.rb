class V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :author, :created_at, :updated_at
end
