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
    click_link 'Upload Portfolio'
    script = "$('#fileupload').css({opacity: '1'});"
    page.execute_script(script)
    attach_file(:file, "#{Rails.root}/test/fixtures/files/portfolio.csv")
    assert page.has_content?('Your Portfolios')
    assert page.has_content?('AAPL')
  end

end
