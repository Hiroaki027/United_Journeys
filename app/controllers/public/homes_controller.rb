class Public::HomesController < ApplicationController
  def top
    @hide_flash = true #flash_messageを非表示
  end
end
