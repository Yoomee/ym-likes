require 'spec_helper'

describe 'YmLikes::Likeable' do
  
  describe Resource do
  
    it { should have_many(:likings) }
    
    describe 'most_likes scope' do
      
      before do
        user = FactoryGirl.create(:user)
        resource1 = FactoryGirl.create(:resource, :id => 1)
        resource2 = FactoryGirl.create(:resource, :id => 2)
        user.likes.create(:resource => resource1)
        2.times {user.likes.create(:resource => resource2)}
      end
      
      it "returns resource with the most likes" do
        Resource.most_likes.collect(&:id).should == [2,1]
      end
      
      it "also includes resources without any likes" do
        FactoryGirl.create(:resource, :id => 3)
        Resource.most_likes.collect(&:id).should == [2,1,3]
      end
      
    end
    
  end
  
end