require "rails_helper"

RSpec.describe "Favoriteモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    it "ユーザーID、投稿IDがある場合、有効である" do
      expect(FactoryBot.build(:favorite)).to be_valid
    end
  end

  describe "アソシエーションのテスト" do
    it "UserモデルとN:1となっている" do
      expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end

  describe "アソシエーションのテスト" do
    it "PostモデルとN:1となっている" do
      expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
    end
  end
end