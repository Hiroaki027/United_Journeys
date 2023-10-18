class Public::ChatsController < ApplicationController
  before_action :authenticate_member!, except: [:top, :admin]
  before_action :reject_non_related, only: [:show]
  def show
    @member = Member.find(params[:id])
    rooms = current_member.member_rooms.pluck(:room_id) #ログインメンバーが所属しているroomをpluckメソッドで全て抽出
    member_rooms = MemberRoom.find_by(member_id: @member.id, room_id: rooms) #MemberRoomモデルからfind_byメソッドでmember_idに対して該当のmemberを1件抽出し、room_idにはroomsを1件抽出

    if member_rooms.present? #member_roomsのidがnillじゃ無ければ= 既存のmember_roomsがあれば
      @room = member_rooms.room #既存のroomへ
    else
      @room = Room.new
      @room.save
      MemberRoom.create(member_id: current_member.id, room_id: @room.id) #ログインメンバーと結びつく中間テーブルを作成
      MemberRoom.create(member_id: @member.id, room_id: @room.id) #相手と結びつく中間テーブルを作成
    end
    @chats = @room.chats #room内のchatを一覧表示させる ##これまでの相手とのやり取りを表示させる
    @chat = Chat.new(room_id: @room.id) #chatの投稿をするため　##room内にメッセージを作成する
  end

  def create
    @chat = current_member.chats.new(chat_params)
    render :validater unless @chat.save #非同期通信化に伴い、chats/vailidater.js.erbを読み込み
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related #相互フォローしていなければ拒絶
    member = Member.find(params[:id])

    #ログインメンバーが相手をfollowしているかつ、相手がログインメンバーをfollowしている場合でなければ　=　相互フォローじゃなければ
    unless current_member.following?(member) && member.following?(current_member)
      redirect_to request.referer #元のページへリダイレクト
    end
  end
end


