require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user =users(:one)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present and valid" do
    @user.email = "hyperx@test.com"
    assert @user.valid?
  end
  
  test "email should be not present" do
    @user.email = nil
    assert !@user.valid?
  end

  test "email should be not valid" do
    @user.email = "hyperx"
    assert !@user.valid?
  end
end
