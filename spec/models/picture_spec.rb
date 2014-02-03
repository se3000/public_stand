require 'spec_helper'

describe Picture do
  describe "#url" do
    context "when there is no key" do
      it "returns includes the S3 bucket and key" do
        picture = Picture.new(s3_key: nil)

        expect(picture.url).to be_nil
      end
    end

    context "when the picture has a key" do
      it "returns includes the S3 bucket and key" do
        picture = Picture.new(s3_key: 's3/image/key.jpg')

        expect(picture.url).to eq 'http://s3-us-west-2.amazonaws.com/publicstand-test/s3/image/key.jpg'
      end
    end
  end
end
