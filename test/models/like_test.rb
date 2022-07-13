# frozen_string_literal: true

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = likes(:one)
    @like2 = likes(:two)
  end

  test 'valid like' do
    assert @like.valid?
  end

  test 'user cannot like same post twice' do
    @like2.post = posts(:one)
    assert_not @like2.valid?
  end
end
