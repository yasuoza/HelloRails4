require 'spec_helper'

feature 'Visit topic_path' do
  subject { page }
  before do
    Topic.create(name: 'topic#1',
                 user_id: current_user.id)
    Topic.create(name: 'topic#2',
                 user_id: current_user.id + 1)
    log_in
  end
  scenario "List current_user's topics" do
    visit root_url
    should have_content 'Listing topics'
    should have_content 'topic#1'
    should_not have_content 'topic#2'
  end
end

feature 'Create new topic' do
  before do
    log_in
    visit new_topic_path
  end

  scenario "Visit new_topic_path" do
    page.should have_selector("input#topic_name")
  end

  scenario "Submit new topic" do
    fill_in "topic_name", with: 'topic#3'
    click_button 'Save'
    current_path.should eq '/topics/1'
    page.should have_content 'Topic was successfully created.'
    page.should have_content 'topic#3'
  end
end

feature 'Show topic' do
  let!(:topic1) { Topic.create(name: 'topic#1', user_id: 1) }
  let!(:topic2) { Topic.create(name: 'topic#2', user_id: 1 + 2) }

  before do
    log_in
  end

  scenario 'see my topic' do
    visit topic_path(topic1)
    page.should have_content topic1.name
  end

  scenario 'see someone created topic' do
    visit topic_path(topic2)
    current_path.should eq '/'
    page.should have_content topic1.name
    page.should_not have_content topic2.name
  end
end

feature 'Update topic' do
  let(:topic) { create(:topic) }
  before do
    log_in
    visit topic_path(topic)
  end

  scenario 'Update' do
    click_link 'Edit'
    page.should have_selector 'input#topic_name'
    fill_in 'topic_name', with: 'New topic name'
    click_button 'Save'
    current_path.should eq topic_path(topic)
    page.should have_content 'New topic name'
  end
end

feature 'Destroy topic' do
  before do
    log_in
    topic = create(:topic)
    visit root_path
  end

  scenario 'Destroy' do
    find('td > a', text: 'Destroy').click
    page.should_not have_content "MyString"
  end
end
