require 'spec_helper'

describe Project do
  
  it "is invalid without a repo name" do
    expect(Project.new(repo_name: nil)).to have(1).errors_on(:repo_name)
  end

  # describe "is invalid if the project has already been created" do
  #   before :each do
  #    project_params = {"utf8"=>"✓", "authenticity_token"=>"s9ewRYOt7RVkOWOWh2Bt3ELC9uQF9C/RVcmBjfotzFE=", "project"=>
  #     {"repo_name"=>"tenderlove/dnssd", "live_url"=>"", "semester_id"=>"001", "images_attributes"=>
  #    {"0"=>{"upload"=>#<ActionDispatch::Http::UploadedFile:0x007fbbd7340360 @original_filename="cover.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"project[images_attributes][0][upload]\"; filename=\"cover.jpg\"\r\nContent-Type: image/jpeg\r\n", @tempfile=#<File:/var/folders/zp/l2tpnj4s27sfkdcwzpfw2z5r0000gn/T/RackMultipart20130411-47082-3hos23>>, "image_type"=>"cover", "position"=>"0"}, "1"=>{"upload"=>#<ActionDispatch::Http::UploadedFile:0x007fbbd7340180 @original_filename="Screen Shot 2013-01-27 at 9.35.50 PM.png", @content_type="image/png", @headers="Content-Disposition: form-data; name=\"project[images_attributes][1][upload]\"; filename=\"Screen Shot 2013-01-27 at 9.35.50 PM.png\"\r\nContent-Type: image/png\r\n", @tempfile=#<File:/var/folders/zp/l2tpnj4s27sfkdcwzpfw2z5r0000gn/T/RackMultipart20130411-47082-e74tmg>>, "image_type"=>"screenshot", "position"=>"0"}}}, "commit"=>"Create Project", "action"=>"create", "controller"=>"projects"/}
     
  #    Project.new(repo_name: 'creaktive/rainbarf', semester: '001', screenshot: 'screenshot.jpg')

    

  # end


# .find_by_repo_name(params[:project][:repo_name])

  # it "is invalid without a screenshot image" do
  #   expect(Image.new(image_type[screenshot]: nil)).to have(1).errors_on(:image_type[:screenshot])
  # end
  it "must have a description" do
    @project = Project.create(:description => 'This Project Does Some Awesome Stuff')
    expect @project.description == 'This Project Does Some Awesome Stuff'
  end

end

# :description
# :github_link
# :name
# :repo_name
# :live_url
# :forks
# :watchers
# :language
# :images_attributes
# :semester_id