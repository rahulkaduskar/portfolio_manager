require 'test_helper'

class ProtfoliosTest < ActiveSupport::TestCase

	test "invalid without date" do
	  line = "AAPL,93.24,1"
    assert_raise Exception, "Line format issue in csv file: Please check line => AAPL,93.24,1" do 
       Portfolio.new(line)
    end
  end

   test "invalid with_invalid price" do
	  line = "AAPL,06/05/2016,sdfsddf,1"
    assert_raises Exception, "Line format issue in csv file: Please check line => AAPL,06/05/2016,sdfsddf,1" do
      Portfolio.new(line)
    end
  end

  test "invalid with invalid qty" do
	  line = "AAPL,06/05/2016,93.24,fsdfsdf"
    assert_raises Exception, "Line format issue in csv file: Please check line => AAPL,06/05/2016,93.24,fsdfsdf" do
      Portfolio.new(line)
    end
  end

  test "valid_with_valid_format" do
	  line = "AAPL,06/05/2016,93.24,2"
    assert_nothing_raised Exception do
      Portfolio.new(line)
    end
  end

  test "calculate_profit_loss" do
    line = "AAPL,06/05/2016,93.24,2"
    portfolio = Portfolio.new(line)
    assert_equal portfolio.calculate_profit_loss(93.24), 0
  end

  test "calculate profit loss with nil current price" do
    line = "AAPL,06/05/2016,93.24,2"
    portfolio = Portfolio.new(line)
    assert_equal portfolio.calculate_profit_loss(nil), 0
  end


end
