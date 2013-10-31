require 'spec_helper'

describe Video do
  it 'saves itself' do
    video = Fabricate(:video)
    expect(Video.first).to eq(video)

  end
  it { should have_many(:categories).through(:categorizations) }

  it 'validates when title is not included' do
    video = Video.create(description:'something')
    expect(Video.count).to eq(0)
  end

  it 'validates when description is not included' do
    video = Video.create(description:'something')
    expect(Video.count).to eq(0)
  end

end