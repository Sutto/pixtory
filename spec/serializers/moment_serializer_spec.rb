require 'spec_helper'

describe MomentSerializer do

  let(:test_image) do
    path = Rails.root.join('spec', 'fixtures', 'test.jpg')
    File.open(path, 'rb')
  end

  after { test_image.close }

  let(:moment) do
    Moment.create!({
      location:         "Perth, Australia",
      coordinates:      [25.0, 20.0],
      caption:          "This is a Test Caption",
      image:            test_image,
      width:            100,
      height:           200,
      captured_at:      Date.new(2000),
      approximate_date: false,
      source_url:       "http://example.com/test",
      description:      "TEST"
    })
  end

  subject { described_class.new(moment).serializable_hash }

  it 'should have the location' do
    subject[:location].should == {
      name: moment.location,
      lat:  25.0,
      lng:  20.0
    }
  end

  it 'should have the id' do
    subject[:id].should be_present
    subject[:id].should == moment.id
  end

  it 'should include full image details' do
    subject[:image].should be_present
    subject[:image][:full].should be_present
    subject[:image][:full][:url].should be_present
    subject[:image][:full][:width].should be_present
    subject[:image][:full][:height].should be_present
  end

  it 'should include primary image details' do
    subject[:image].should be_present
    subject[:image][:primary].should be_present
    subject[:image][:primary][:url].should be_present
    subject[:image][:primary][:width].should be_present
    subject[:image][:primary][:height].should be_present
  end

  it 'should include thumb image details' do
    subject[:image].should be_present
    subject[:image][:thumb].should be_present
    subject[:image][:thumb][:url].should be_present
    subject[:image][:thumb][:width].should be_present
    subject[:image][:thumb][:height].should be_present
  end

  it 'should include square image details' do
    subject[:image].should be_present
    subject[:image][:square].should be_present
    subject[:image][:square][:url].should be_present
    subject[:image][:square][:width].should be_present
    subject[:image][:square][:height].should be_present
  end

  it 'should include the caption' do
    subject[:caption].should be_present
    subject[:caption].should == moment.caption
  end

  it 'should include the formatted timestamp' do
    subject[:formatted_timestamp].should be_present
    subject[:formatted_timestamp].should == moment.formatted_timestamp
  end

  it 'should include the source url' do
    subject[:source_url].should be_present
    subject[:source_url].should == moment.source_url
  end

  context 'links' do


    it 'should have no links without a controller' do
      subject.should have_key :links
      subject[:links].should == {}
    end

    context 'with a controller' do

      let(:controller) do
        o = Object.new
        stub(o).explore_moment_url(anything) { |m| "moment=#{m.to_param}" }
        stub(o).moment_url.with_any_args do |*args|
          options = args.extract_options!
          moment = args.shift
          "#{moment.to_param}?#{options.to_param}"
        end
        o
      end

      subject { described_class.new(moment, controller: controller).serializable_hash }

      it 'should have links' do
        subject[:links].should be_present
        subject[:links].should be_a Hash
      end

      it 'should have a link to the web version' do
        subject[:links][:web].should == "moment=#{moment.to_param}"
      end

      it 'should have a link to the current version' do
        subject[:links][:self].should == "#{moment.to_param}?format=json"
      end

      it 'should have a link to the geojson version' do
        subject[:links][:geojson].should == "#{moment.to_param}?format=geojson"
      end

      it 'should have a link to the kml' do
        subject[:links][:kml].should == "#{moment.to_param}?format=kml"
      end

    end

  end

end
