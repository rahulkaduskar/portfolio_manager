require "test_helper"

class PortfoliosTest < Capybara::Rails::TestCase
  # test "Check home page" do
  #   visit root_path
  #   assert_content page, "Your Portfolis"
  # end

  # test "Check invalid portfolio file upload " do
  #   visit root_path
  #   #click_link 'Upload Portfolio'
  #   assert_content page, "Upload your Portfolios:"
  #   page.attach_file('Upload Portfolio', "#{Rails.root}/test/fixtures/files/invalid.txt")
  #   #binding.pry
  #   assert_content page, "Please upload only csv file."
  # end

  # test "Check invalid file type upload " do
  #   visit root_path
  #   click_link 'Upload Portfolio'
  #   assert_content page, "Upload your Portfolios:"
  #   post :import_portfolios, :upload => "#{Rails.root}/test/fixtures/files/invalidfile.csv"

  #   # find('#fileupload').click
  #   # attach_file('file', "#{Rails.root}/test/fixtures/files/invalid.txt")
  #   page.has_content?('Please upload only csv file.')
  # end
end
