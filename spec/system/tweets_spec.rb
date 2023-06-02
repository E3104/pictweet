context 'ツイート編集ができるとき' do
  it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
    # ツイート1を投稿したユーザーでログインする
    visit new_user_session_path
    fill_in 'Email', with: @tweet1.user.email
    fill_in 'Password', with: @tweet1.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # ツイート1に「編集」へのリンクがあることを確認する
    expect(
      all('.more')[1].hover
    ).to have_link '編集', href: edit_tweet_path(@tweet1)
    # 編集ページへ遷移する
    visit edit_tweet_path(@tweet1)
    # すでに投稿済みの内容がフォームに入っていることを確認する
    expect(
      find('#tweet_image').value
    ).to eq(@tweet1.image)
    expect(
      find('#tweet_text').value
    ).to eq(@tweet1.text)
    # 投稿内容を編集する
    fill_in 'tweet_image', with: "#{@tweet1.image}+編集した画像URL"
    fill_in 'tweet_text', with: "#{@tweet1.text}+編集したテキスト"
    # 編集してもTweetモデルのカウントは変わらないことを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Tweet.count }.by(0)
    # 編集完了画面に遷移したことを確認する
    expect(current_path).to eq(tweet_path(@tweet1))
    # 「更新が完了しました」の文字があることを確認する
    expect(page).to have_content('更新が完了しました。')
    # トップページに遷移する
    visit root_path
    # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
    expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet1.image}+編集した画像URL);']"
    # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
    expect(page).to have_content("#{@tweet1.text}+編集したテキスト")
  end
end