require 'rails_helper'
describe TweetsController, type: :request do

  before do
    @tweet = FactoryBot.create(:tweet)
  end

  #indexアクションにリクエストした際のテストコードは省略しています。
  #indexアクションのテストコードに続いて記述してください。

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get tweet_path(@tweet)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
    end
  end 
end
