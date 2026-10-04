require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "stan's online book store order confirmation", mail.subject
    assert_equal [ "stan@marvel.com" ], mail.to
    assert_equal [ "stansbookstore1@gmail.com" ], mail.from

  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "stan's online book store order shipped", mail.subject
    assert_equal [ "stan@marvel.com" ], mail.to
    assert_equal [ "stansbookstore1@gmail.com" ], mail.from
  end
end
