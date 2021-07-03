require "rails_helper"

RSpec.describe "Commentモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    it "ユーザーID、投稿ID、コメントがある場合、有効である" do
      expect(FactoryBot.build(:comment)).to be_valid
    end
    it "コメントがない場合、無効である" do
      expect(FactoryBot.build(:comment, comment: nil)).not_to be_valid
    end
  end

  describe "アソシエーションのテスト" do
    it "UserモデルとN:1となっている" do
      expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end

  describe "アソシエーションのテスト" do
    it "PostモデルとN:1となっている" do
      expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
    end
  end
end