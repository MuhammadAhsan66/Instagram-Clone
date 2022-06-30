# frozen_string_literal: true

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = likes(:one)
  end

  test 'valid like' do
    assert @like.valid?
  end
end
