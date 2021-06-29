require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    it "名前(2〜25文字以内)、メール、パスワード(6文字以上)がある場合、有効である" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it "名前がない場合、無効である" do
      expect(FactoryBot.build(:user, name: nil)).not_to be_valid
    end

    it "名前が2文字未満の場合、無効である" do
      expect(FactoryBot.build(:user, name: "1")).not_to be_valid
    end

    it "名前が25文字を超える場合、無効である" do
      expect(FactoryBot.build(:user, name: "これは25文字を超える名前。これは25文字を超える名前。")).not_to be_valid
    end

    it "メールアドレスがない場合、無効である" do
      expect(FactoryBot.build(:user, email: nil)).not_to be_valid
    end

    it "重複したメールアドレスの場合、無効である" do
      another_user = FactoryBot.create(:user, email: "user@test.com")
      expect(FactoryBot.build(:user, email: another_user.email)).not_to be_valid
    end

    it "パスワードがない場合、無効である" do
      expect(FactoryBot.build(:user, password: nil)).not_to be_valid
    end

    it "パスワードが6文字未満の場合、無効である" do
      expect(FactoryBot.build(:user, password: "12345")).not_to be_valid
    end

    it "パスワードと確認用パスワードが一致しない場合、無効である" do
      expect(FactoryBot.build(:user, password: "password", password_confirmation: "passwaad")).not_to be_valid
    end

    it "自己紹介がなくても、有効である" do
      expect(FactoryBot.build(:user, introduction: nil)).to be_valid
    end
  end

  describe "アソシエーションのテスト" do
    it "Postモデルと1:Nとなっている" do
      expect(User.reflect_on_association(:posts).macro).to eq :has_many
    end

    it "Likeモデルと1:Nとなっている" do
      expect(User.reflect_on_association(:likes).macro).to eq :has_many
    end

    it "Commentモデルと1:Nとなっている" do
      expect(User.reflect_on_association(:comments).macro).to eq :has_many
    end

    it "Favoriteモデルと1:Nとなっている" do
      expect(User.reflect_on_association(:favorites).macro).to eq :has_many
    end
  end
end