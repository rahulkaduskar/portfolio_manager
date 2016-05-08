require 'test_helper'

class PortfoliosControllerTest < ActionController::TestCase
	def setup
    Rails.cache.delete(PortfolioManagement::FILE_FOR_PORTFOLIO)
    Rails.cache.delete(PortfolioManagement::FILE_FOR_SHAREPRICE)
  end

  test "should get index with no data" do
    get :index
    assert_response :success
    assert_empty assigns(:portfolios)
    assert_empty assigns(:current_prices)
  end

  test "should get index with portfolio data only" do
    get :index
    portfolios = {}
    portfolios["Profile 1"] = []
    portfolios["Profile 1"] << Portfolio.new("AAPL,06/05/16,93.24,1")
    Rails.cache.write(PortfolioManagement::FILE_FOR_PORTFOLIO, portfolios)
    assert_response :success
    assert_not_nil assigns(:portfolios)
    assert_empty assigns(:current_prices)
  end

  test "should get index with portfolio & current share price data" do
    get :index
    assert_response :success
    portfolios = {}
    portfolios["Profile 1"] = []
    portfolios["Profile 1"]  << Portfolio.new("AAPL,06/05/16,93.24,1")
    Rails.cache.write(PortfolioManagement::FILE_FOR_PORTFOLIO, portfolios)
    shareprices = {"07/05/2016"=>{"AAPL"=>23.24}}
    Rails.cache.write(PortfolioManagement::FILE_FOR_SHAREPRICE, shareprices)
    assert_not_nil assigns(:portfolios)
    assert_empty assigns(:current_prices)
  end

  test "upload valid portfolio file and check success response " do
    file = fixture_file_upload("#{Rails.root}/test/fixtures/files/portfolio.csv", "text/csv")
    post "import", { file: file, 
      file_for: PortfolioManagement::FILE_FOR_PORTFOLIO}
    assert_response :success
  end

  test "upload invalid file and check error response " do
    file = fixture_file_upload("#{Rails.root}/test/fixtures/files/invalid.txt", "text/plain")
    post "import", { file: file, 
      file_for: PortfolioManagement::FILE_FOR_PORTFOLIO}
    assert_response 400
  end

  test "upload valid file and check success response " do
    file = fixture_file_upload("#{Rails.root}/test/fixtures/files/sharePrice.csv", "text/csv")
    post "import", { file: file, 
      file_for: PortfolioManagement::FILE_FOR_SHAREPRICE}
    assert_response :success
  end

  test "upload invalid data format file and check success response " do
    file = fixture_file_upload("#{Rails.root}/test/fixtures/files/invalidShare_price.csv", "text/csv")
    post "import", { file: file, 
      file_for: PortfolioManagement::FILE_FOR_SHAREPRICE}
    assert_response 400
  end

end
