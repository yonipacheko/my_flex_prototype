require 'spec_helper'

#describe LargeCoverUploader do
#  include CarrierWave::Test::Matchers
#
#  let(:video) { Fabricate(:video) }
#  let(:file_path) { "#{Rails.root}/spec/support/dr_who.jpg" }
#
#  before do
#    LargeCoverUploader.enable_processing = true
#  end
#
#
#  describe "in isoloation" do
#    before do
#      @uploader = LargeCoverUploader.new(video, :large_cover)
#      @uploader.store!(File.open(file_path))
#    end
#
#    it "stores the file uploaded with the same file size" do
#      expect(File.size(@uploader.current_path)).to eq(85431)
#    end
#
#    after do
#      @uploader.remove!
#    end
#  end
#
#  describe "as part of the Video AR model" do
#    it "saves the upload with the ar record" do
#      video.large_cover = File.open(file_path)
#      video.save!
#      video.reload
#      expect(video.large_cover.url).to eq("/uploads/dr_who.jpg")
#    end
#  end


#end

