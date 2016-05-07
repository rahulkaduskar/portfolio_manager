class PortfoliosController < ApplicationController


	def index
		@portfolios = Rails.cache.read(PortfolioManagement::FILE_FOR_PORTFOLIO) || {}
		shareprices = Rails.cache.read(PortfolioManagement::FILE_FOR_SHAREPRICE) || {}	
		@current_prices = shareprices.present? ? shareprices[Date.today.strftime('%d/%m/%Y')] : {}
	end

	def import_form
		@file_for = params[:file_for].blank? ? PortfolioManagement::FILE_FOR_PORTFOLIO : PortfolioManagement::FILE_FOR_SHAREPRICE
	end

	def import
		bindint.pry
		file_data = params[:file]
		if file_data.content_type == "text/csv" && file_data.respond_to?(:read)
		  portfolio_data = file_data.read
		  success, error_msg = 	read_create_list(portfolio_data, params[:file_for])	
		else
		  error_msg = "Please upload only csv file."
		end	
		if !success
			render json: {error: error_msg}, status: :unprocessable_entity
		else
			render json: {redirect_url: portfolios_url}, status: :ok
		end
	end

	def show
		@profile = params[:id]
		@portfolios = Rails.cache.read(PortfolioManagement::FILE_FOR_PORTFOLIO) || {}
		@myportfolio = @portfolios[@profile]
		shareprices = Rails.cache.read(PortfolioManagement::FILE_FOR_SHAREPRICE) || {}	
		@current_prices = shareprices.present? ? shareprices[Date.today.strftime('%d/%m/%Y')] : {}
	end

	private
	def read_create_list(contents, list_for)
		portfolios_data = Rails.cache.read(PortfolioManagement::FILE_FOR_PORTFOLIO) || {}
		key = "Portfolio_#{portfolios_data.keys.length + 1}"
		portfolios_data[key] = []
		begin
			contents.split("\n").each do | line|
				next if line.split(",").reject{|r| r.blank?}.blank?				
				if list_for == PortfolioManagement::FILE_FOR_SHAREPRICE 
	 			  build_share_hash(line) unless line.start_with?("Ticket name")
				else
					portfolios_data[key] << Portfolio.new(line) unless line.start_with?("Ticket name")
				end			
			end		
		rescue => error
			Rails.logger.error(" line format issue: #{error.message}")
			return false, " #{error.message}"
		end	
		Rails.cache.write("#{list_for}",portfolios_data ) if list_for == PortfolioManagement::FILE_FOR_PORTFOLIO  

		return true
	end

	def build_share_hash(line)
		shareprices = Rails.cache.read(PortfolioManagement::FILE_FOR_SHAREPRICE) || {}
		begin
	  	share_data = line.split(",")	  
  		ticket_name = share_data[0]
  		date = Date.strptime(share_data[1], '%d/%m/%Y')
  		price = share_data[2].to_f
  		shareprices[date.strftime('%d/%m/%Y')] = {} if shareprices[date.strftime('%d/%m/%Y')].blank?
  		shareprices[date.strftime('%d/%m/%Y')].merge!(ticket_name => price)
  	rescue => error
			Rails.logger.error("Line format issue in csv file: #{line}")
			raise "Line format issue in csv file: Please check line => #{line}"
		end
		
		Rails.cache.write(PortfolioManagement::FILE_FOR_SHAREPRICE, shareprices) 
	end

end
