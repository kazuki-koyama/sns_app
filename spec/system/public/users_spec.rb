require "rails_helper"

RSpec.describe "Users", type: :system do
  describe "ユーザー新規登録" do
    context "新規登録できる場合" do
      it '新規ユーザー登録画面に遷移する' do
        visit root_path
        click_link '新規登録'
        expect(page).to have_current_path '/users/sign_up'
      end

      it "内容を入力し、'新規登録'ボタンを選択するとホーム画面に遷移する。" do
        user = build(:user)
        visit new_user_registration_path
        fill_in "お名前", with: user.name
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード（6文字以上）", with: user.password
        fill_in "パスワード確認", with: user.password_confirmation
        aggregate_failures do
          expect do
          click_button "新規登録"
          end.to change(User, :count).by(1)
          expect(current_path).to eq "/home"
          expect(page).to have_content("新規登録が完了しました")
        end
      end
    end

    context "新規登録できない場合" do
      it "内容を入力し、'新規登録'ボタンを選択するとエラーメッセージが表示される。" do
        user = build(:user)
        visit new_user_registration_path
        fill_in "お名前", with: "あ"
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード（6文字以上）", with: user.password
        fill_in "パスワード確認", with: user.password_confirmation
        aggregate_failures do
          expect do
          click_button "新規登録"
          end.to change(User, :count).by(0)
          expect(current_path).to eq "/users/sign_up"
          expect(page).to have_content("名前は2文字以上で入力してください")
        end
      end
    end
  end

  describe "ログイン" do
    let(:user) { create(:user) }
    context "成功する場合" do
      it 'ログイン画面に遷移する' do
        visit root_path
        click_link 'ログイン'
        expect(page).to have_current_path '/users/sign_in'
      end

      it "内容を入力し、'ログイン'ボタンを選択するとホーム画面に遷移する。" do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
        aggregate_failures do
          expect(current_path).to eq "/home"
          expect(page).to have_content("ログインしました")
        end
      end
    end

    context "失敗する場合" do
      it "内容を入力し、'ログイン'ボタンを選択するとエラーメッセージが表示される。" do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "111111"
        click_button "ログイン"
        aggregate_failures do
          expect(current_path).to eq "/users/sign_in"
          expect(page).to have_content("メールアドレスまたはパスワードが違います。")
        end
      end
    end
  end

  describe "ログアウト" do
    let(:user) { create(:user) }
    it "ログアウトしたらトップ画面に遷移する。" do
      sign_in_as(user)
      visit '/home'
      find(".logout_test").click
      aggregate_failures do
        expect(current_path).to eq "/"
        expect(page).to have_link("ログイン")
        expect(page).to have_content("ログアウトしました。")
      end
    end
  end

  describe 'ゲストログイン' do
    let(:user) { create(:user) }
    it 'トップページからゲストログインできる' do
      visit root_path
      click_link 'ゲストログイン（閲覧用）'
      expect(page).to have_current_path '/home'
    end
  end

  describe "ユーザー詳細画面" do
    let(:user) { create(:user) }
    it "プロフィール編集リンクがある。" do
    sign_in_as(user)
    visit user_path(user.id)
    expect(page).to have_content("プロフィールを編集")
    end
  end

  describe "プロフィールを編集する" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    context "編集に成功する場合" do
      before do
        sign_in_as(user)
        visit user_path(user.id)
        find(".btn__edit-profile").click
      end

      it "編集後、プロフィール画面に遷移する。プロフィール画面には編集後の情報が表示されている。" do
        fill_in "アカウント名", with: "アカウント名更新"
        fill_in "自己紹介", with: "自己紹介を更新しました。"
        fill_in "メールアドレス", with: "userupdate@example.com"
        click_button "Update"
        aggregate_failures do
          expect(current_path).to eq "/users/#{user.id}"
          expect(find('.info__user-name').text).to eq "アカウント名更新"
          expect(find('.info__caption').text).to eq "自己紹介を更新しました。"
        end
      end
    end

    context "編集に失敗する場合" do
      before do
        sign_in_as(user)
        visit user_path(user.id)
        find(".btn__edit-profile").click
      end

      it "内容を入力し、'更新する'ボタンを選択するとエラーメッセージが表示される。" do
        fill_in "アカウント名", with: "あ" * 26
        fill_in "自己紹介", with: "自己紹介を更新しました。"
        fill_in "メールアドレス", with: "userupdate@example.com"
        click_button "Update"
        aggregate_failures do
          expect(page).to have_content("名前は25文字以内で入力してください")
        end
      end
    end

    context '他人のプロフィール画面の場合' do
      it 'プロフィールを編集リンクがない' do
        sign_in_as(user)
        visit user_path(another_user.id)
        expect(page).not_to have_content 'プロフィールを編集'
      end
    end
  end

  describe "おすすめユーザー一覧画面" do
    let(:user) { create(:user) }
    before do
      sign_in_as(user)
      visit '/home'
    end

    it "ホーム画面に'おすすめユーザー一覧'リンクがある。" do
      aggregate_failures do
        expect(current_path).to eq "/home"
        expect(page).to have_content("すべて見る")
      end
    end

    it "'おすすめユーザー一覧'リンクを選択するとおすすめユーザー一覧画面に遷移する。" do
      find(".main-aside__link").click
      aggregate_failures do
        expect(current_path).to eq "/users"
        expect(page).to have_content("おすすめ")
      end
    end
  end
end