class BlogsIndex < Chewy::Index
    settings analysis: {
      analyzer: {
        title: {
          tokenizer: 'standard',
          filter: ['lowercase']
        }
      }
    }

    index_scope Blog.includes(:images, :user)
    field :title, analyzer: 'title'
    field :description
    field :user, value: ->{ user.uid }
    field :user_id, type: 'integer'
    field :images, index: 'not_analyzed', value: ->{ images.map(&:url) }
    
    
  end