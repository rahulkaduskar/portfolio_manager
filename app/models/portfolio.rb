class Portfolio

  attr_accessor :ticket_name, :purchase_date, :purchase_price, :purchase_qty

  def initialize(line)
  	begin
	  	portfolio_data = line.split(",")
	  	#raise "unsufficient data" if portfolio_data.length != 3
  		@ticket_name = portfolio_data[0]
  		@purchase_date = Date.strptime(portfolio_data[1], "%d/%m/%Y") 
  		@purchase_price = Float(portfolio_data[2])
  		@purchase_qty = Integer(portfolio_data[3])
  	rescue => error
			Rails.logger.error(" line format issue in csv file : #{line}")
      raise "Line format issue in csv file: Please check line => #{line}"
		end
  end

  def calculate_profit_loss(current_price)
    return ((current_price - self.purchase_price) * self.purchase_qty).round(2) 
  end

end
