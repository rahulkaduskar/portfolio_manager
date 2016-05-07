require 'test_helper'

class PortfoliosControllerTest < ActionController::TestCase
	def setup
    Rails.cache.delete(PortfolioManagement::FILE_FOR_PORTFOLIO)
    Rails.cache.delete(PortfolioManagement::FILE_FOR_SHAREPRICE)
  end

  # test "should get index with not data" do
  #   get :index
  #   assert_response :success
  #   assert_empty assigns(:portfolios)
  #   assert_empty assigns(:current_prices)
  # end

  # test "should get index with portfolio data only" do
  #   get :index
  #   portfolios = {}
  #   portfolios["Profile 1"] = []
  #   portfolios["Profile 1"] << Portfolio.new("AAPL,06/05/16,93.24,1")
  #   Rails.cache.write(PortfolioManagement::FILE_FOR_PORTFOLIO, portfolios)
  #   assert_response :success
  #   assert_not_nil assigns(:portfolios)
  #   assert_empty assigns(:current_prices)
  # end

  # test "should get index with portfolio & current share price data" do
  #   get :index
  #   assert_response :success
  #   portfolios = {}
  #   portfolios["Profile 1"] = []
  #   portfolios["Profile 1"]  << Portfolio.new("AAPL,06/05/16,93.24,1")
  #   Rails.cache.write(PortfolioManagement::FILE_FOR_PORTFOLIO, portfolios)
  #   shareprices = {"07/05/2016"=>{"AAPL"=>23.24}}
  #   Rails.cache.write(PortfolioManagement::FILE_FOR_SHAREPRICE, shareprices)
  #   assert_not_nil assigns(:portfolios)
  #   assert_empty assigns(:current_prices)
  # end

  test "should get index with portfolio & current share price data" do
    post :import_form, :file => "#{Rails.root}/test/fixtures/files/invalid.txt"
    assert_response :error
   # binding.pry
    # upload_resp = JSON.parse(@response.body)
    # assert_equal "Please upload only csv file.", upload_resp[:error]
  end

end
