require "rails_helper"

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }

  describe "投稿する" do
    before do
      sign_in_as(user)
      visit '/home'
    end

    context "投稿に成功する場合" do
      it "ホーム画面に'New Post'リンクがある。" do
        expect(page).to have_content("New Post")
      end

      it "'New Post'リンクを押すと投稿作成ウィンドウが表示される。" do
        find(".side-nav__post-btn").click
        expect(page).to have_content("投稿")
      end

      it "内容を入力し、'投稿'ボタンを押すと投稿が追加される。" do
        find(".side-nav__post-btn").click
        # post = build(:post)
        # find('input[type="file"]').click
        attach_file 'before_image', "#{Rails.root}/db/fixtures/icon0-min.jpg"
        attach_file 'after_image', "#{Rails.root}/db/fixtures/icon1-min.jpg"
        fill_in "caption", with: "キャプションです。"
        aggregate_failures do
          expect do
          click_button "投稿"
          end.to change(user.posts, :count).by(1)
          expect(page).to have_content("キャプションです。")
        end
      end
    end

    context "作成に失敗する場合" do
      before do
        find(".side-nav__post-btn").click
      end

      it "内容を入力し、'投稿'ボタンを押すとアラートメッセージが表示される。" do
        attach_file 'before_image', "#{Rails.root}/db/fixtures/icon0-min.jpg"
        fill_in "caption", with: "キャプションです。"
        aggregate_failures do
          expect do
          click_button "投稿"
          end.to change(user.posts, :count).by(0)
          expect(page.driver.browser.switch_to.alert.text).to eq 'before画像とafter画像が正しく選択されているかご確認ください'
          page.driver.browser.switch_to.alert.dismiss
        end
      end
    end
  end

  describe "投稿を編集する" do
    before do
      create(:post, user: user)
      sign_in_as(user)
    end

    context "編集が成功する場合" do
      it "ホーム画面の'編集'アイコンを押すと投稿編集画面に遷移する。" do
        find(".link__edit").click
        aggregate_failures do
          expect(current_path).to eq "/posts/1/edit"
          expect(page).to have_content("投稿を編集")
        end
      end

      it "内容を編集し、'Update'ボタンを押すと編集内容が反映されている。" do
        find(".link__edit").click
        fill_in "caption", with: "キャプションの更新"
        click_button "Update"
        aggregate_failures do
          expect(current_path).to eq "/posts/1"
          expect(page).to have_content("投稿を更新しました")
        end
      end
    end

    context "編集が失敗する場合" do
      it "内容を編集し、'Update'ボタンを押すとエラーメッセージが表示される。" do
        find(".link__edit").click
        fill_in "caption", with: "あ" * 301
        click_button "Update"
        aggregate_failures do
          expect(current_path).to eq "/posts/1/edit"
          expect(page).to have_content("キャプションは300文字以内で入力してください")
        end
      end
    end
  end

  describe "投稿を削除する" do
    before do
      create(:post, user: user)
      sign_in_as(user)
      visit '/home'
      find(".link__edit").click
    end

    it "'削除'ボタンを押し確認ダイアログを承認すると、投稿が削除される。" do
      aggregate_failures do
        expect do
        click_on "削除"
        page.driver.browser.switch_to.alert.accept
        end.to change(user.posts, :count).by(-1)
        expect(current_path).to eq "/posts"
      end
    end
  end
end