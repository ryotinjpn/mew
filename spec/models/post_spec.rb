require 'rails_helper'
describe Post do
  describe '#create' do
    context 'can save' do
      it 'is valid with content and picture' do
        post = create(:post)
        expect(post).to be_valid
      end
    end

    context 'can not save' do
      it 'is valid with content' do
        post = build(:post, picture: nil)
        post.valid?
        expect(post .errors[:picture]).to include("を入力してください")
      end

      it 'is valid with picture' do
        post = build(:post, content: nil)
        post.valid?
        expect(post .errors[:content]).to include("を入力してください")
      end

      it 'is invalid without content and picture' do
        post = build(:post, content: nil, picture: nil)
        post.valid?
        expect(post .errors[:content]).to include("を入力してください")
      end

      it 'is invaid without user_id' do
        post = build(:post, user_id: nil)
        post.valid?
        expect(post.errors[:user]).to include("を入力してください")
      end
    end
  end
end
