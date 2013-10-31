require 'spec_helper'

describe Category do
  it 'saves itself' do
    category = Fabricate(:category)
    expect(Category.first).to eq(category)
  end
  it { should have_many(:videos).through(:categorizations) }
end