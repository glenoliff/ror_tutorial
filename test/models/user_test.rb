require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Example User", email: "user@example.org",
										 password: "foobar", password_confirmation: "foobar")
	end

	test "should be valid" do
		assert@user.valid?
	end

	test "name should be present" do
		@user.name = "    "
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = "    "
		assert_not @user.valid?
	end

	test "name should not be too long" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org 
												 first.last@foo.jp alice+bob@baz.com]

		valid_addresses.each do |addr|
			@user.email = addr
			assert @user.valid?, "#{addr.inspect} should be valid"
		end
	end

	test "email validation should reject valid addresses" do
		valid_addresses = %w[user@example,com user_at_foo.com user.name@example. 
											   foo@bar_baz.com foo@bar+baz.com foo@bar..com]

		valid_addresses.each do |addr|
			@user.email = addr
			assert_not @user.valid?, "#{addr.inspect} should be invalid"
		end
	end

#	test "email addresses should be unique" do
#		duplicate_user = @user.dup
#		@user.save
#		duplicate_user.email = @user.email.upcase
#		puts "#{duplicate_user.valid?} #{duplicate_user.email}" 
#		assert_not duplicate_user.valid?
#	end

	test "email addresses should be saved as lowercase" do
		mixed_case = "Foo@example.CoM"
		@user.email = mixed_case
		@user.save
		assert_equal mixed_case.downcase, @user.reload.email
	end

	test "password should be present nonblank" do
		@user.password = @user.password_confirmation = " " * 6
		assert_not @user.valid?
	end

	test "password should be present and long enough" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end

end
