require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  def setup
    @author = Author.new(name: "Example", email: "example@author.com",
      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @author.valid?
  end

  test "name should be present" do
    @author.name = "   "
    assert_not @author.valid?
  end

  test "email should be present" do
    @author.email = "   "
    assert_not @author.valid?
  end

  test "name should not be too long" do
    @author.name = "a" * 51
    assert_not @author.valid?
  end

  test "email should not be too long" do
    @author.email = "a" * 244 + "@examplec.com"
    assert_not @author.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @author.email = valid_address
      assert @author.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[author@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @author.email = invalid_address
      assert_not @author.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @author.dup
    duplicate_user.email = @author.email.upcase
    @author.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExaMplE.cOm"
    @author.email = mixed_case_email
    @author.save
    assert_equal mixed_case_email.downcase, @author.reload.email
  end

  test "password should be present (nonblank)" do
    @author.password = @author.password_confirmation = " " * 6
    assert_not @author.valid?
  end

  test "password should have a minimum length" do
    @author.password = @author.password_confirmation = "a" * 5
    assert_not @author.valid?
  end
  
end
