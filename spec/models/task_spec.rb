require 'rails_helper'


RSpec.describe Task, type: :model do
  let(:task) { build(:task, done: false)}
  it "is change column by function 'complete'" do
    task.complete
    expect(task.done).to eq true 
  end
end
