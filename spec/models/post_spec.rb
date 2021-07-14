require "rails_helper"

RSpec.describe "Postモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    it "before画像とafter画像がある場合、有効である" do
      expect(FactoryBot.build(:post)).to be_valid
    end

    it "before画像がない場合、無効である" do
      expect(FactoryBot.build(:post, before_image: nil)).not_to be_valid
    end

    it "after画像がない場合、無効である" do
      expect(FactoryBot.build(:post, after_image: nil)).not_to be_valid
    end

    it "キャプションが300文字を超える場合、無効である" do
      expect(FactoryBot.build(:post, caption: "あ" * 301)).not_to be_valid
    end

    it "キャプションがなくても、有効である" do
      expect(FactoryBot.build(:post, caption: nil)).to be_valid
    end
  end

  describe "アソシエーションのテスト" do
    it "UserモデルとN:1となっている" do
      expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it "Likeモデルと1:Nとなっている" do
      expect(Post.reflect_on_association(:likes).macro).to eq :has_many
    end

    it "Commentモデルと1:Nとなっている" do
      expect(Post.reflect_on_association(:comments).macro).to eq :has_many
    end

    it "Favoriteモデルと1:Nとなっている" do
      expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
    end
  end
end