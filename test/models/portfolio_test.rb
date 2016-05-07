require 'test_helper'

class ProtfoliosTest < ActiveSupport::TestCase

	def test_invalid_without_date
	  line = "AAPL,93.24,1"
    assert_raise Exception, "Line format issue in csv file: Please check line => AAPL,93.24,1" do 
       Portfolio.new(line)
    end
  end

  def test_invalid_with_invalid_price
	  line = "AAPL,06/05/2016,sdfsddf,1"
    assert_raises Exception, "Line format issue in csv file: Please check line => AAPL,06/05/2016,sdfsddf,1" do
      Portfolio.new(line)
    end
  end

  def test_invalid_with_invalid_qty
	  line = "AAPL,06/05/2016,93.24,fsdfsdf"
    assert_raises Exception, "Line format issue in csv file: Please check line => AAPL,06/05/2016,93.24,fsdfsdf" do
      Portfolio.new(line)
    end
  end

  def test_valid_with_valid_format
	  line = "AAPL,06/05/2016,93.24,2"
    assert_nothing_raised Exception do
      Portfolio.new(line)
    end
  end


end
