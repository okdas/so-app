require 'spec_helper'

describe Question do

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  # TODO: uniqueness tests with a factory girl
  it { should validate_uniqueness_of(:title).with_message('This question is already exists.') }

  it do
    should ensure_length_of(:title).
               is_at_least(10).
               is_at_most(40).
               with_short_message('Title must be more than 10 characters').
               with_long_message('Title cannot be more than 40 characters')
  end

  it do
    should ensure_length_of(:body).
               is_at_least(50).
               is_at_most(5000).
               with_short_message('Question must be more than 50 characters').
               with_long_message('Question cannot be more than 5000 characters')
  end

  it { should belong_to(:user) }

end
