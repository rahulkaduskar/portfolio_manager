require "test_helper"

class PortfoliosTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end
  
  test "Check home page" do
    visit root_path
    assert page.has_content?('Your Portfolios')
  end

  test "Check invalid portfolio file upload " do
    visit root_path   
    click_link 'Upload Portfolio'
    assert page.has_content?('Upload your Portfolios:')
    click_link 'Upload Portfolio'
    script = "$('#fileupload').css({opacity: '1'});"
    page.execute_script(script)
    attach_file(:file, "#{Rails.root}/test/fixtures/files/invalid.txt")
    assert page.has_content?('Please upload only csv file.')
  end

  test "Check valid portfolio file upload " do
    visit root_path   
    click_link 'Upload Portfolio'
    assert page.has_content?('Upload your Portfolios:')
    script = "$('#fileupload').css({opacity: '1'});"
    page.execute_script(script)
    attach_file(:file, "#{Rails.root}/test/fixtures/files/portfolio.csv")
    assert page.has_content?('Your Portfolios')
    assert page.has_content?('AAPL')
  end

  test "Check valid invalid current share price file upload " do
    visit root_path   
    click_link 'Upload Current Price'
    assert page.has_content?('Upload current Share Price:')
    script = "$('#fileupload').css({opacity: '1'});"
    page.execute_script(script)
    attach_file(:file, "#{Rails.root}/test/fixtures/files/invalidfile.csv")
    assert page.has_content?('Line format issue in csv file: Please check line => AAPL,,23.24')
  end

  test "Check valid current share price file upload " do
    visit root_path   
    click_link 'Upload Current Price'
    assert page.has_content?('Upload current Share Price:')
    script = "$('#fileupload').css({opacity: '1'});"
    page.execute_script(script)
    attach_file(:file, "#{Rails.root}/test/fixtures/files/sharePrice.csv")
    assert page.has_content?('Your Portfolios')
    assert page.has_content?('Portfolios not available.')
  end

  test "Check valid portfolio with current share price file and portfolio file " do
    visit root_path   
    click_link 'Upload Portfolio'
    assert page.has_content?('Upload your Portfolios:')
    script = "$('#fileupload').css({opacity: '1'});"
    page.execute_script(script)
    attach_file(:file, "#{Rails.root}/test/fixtures/files/portfolio.csv")
    click_link 'Upload Current Price'
    assert page.has_content?('Upload current Share Price:')
    script = "$('#fileupload').css({opacity: '1'});"
    page.execute_script(script)
    attach_file(:file, "#{Rails.root}/test/fixtures/files/sharePrice.csv")
    assert page.has_content?('Your Portfolios')
    assert page.has_content?('AAPL')
    assert page.has_content?('-70.0')
  end
end
