# -*- coding: utf-8 -*-

#マルペケゲーム
module TickTack

  #審判
  class Judge
    WIN_PATTERN = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    
    #判定、勝ちならtrue
    def self.win?(player)
      return false if player.hand.size < 3

      WIN_PATTERN.each do |pattern|
        return true if (player.hand.sort & pattern).size == 3
      end

      false
    end
  end

  #プレイヤー
  class Player
    attr_accessor :name, :hand

    def initialize(name)
      @name = name
      reset!
    end
    
    #出目を選び、印をつける。選択できたらtrueが返る
    #盤は破壊していく（笑）
    def choice(board)
      return false if board.empty?

      choiced = board.shuffle.first

      if board.include? choiced
        @hand.push(choiced) && board.delete(choiced)
      else
        choice(board)
      end

      true
    end

    def reset!
      @hand = []
    end
  end

  #ゲーム
  class Game
    #試合開始
    #:p1, :p2, :draw のいずれかが返る
    def self.play
      pair, board = [Player.new(:p1), Player.new(:p2)], (1..9).to_a

      # 決着着くまで◯を付け合う
      until board.empty?
        pair.each do |player|
          return player.name if player.choice(board) && Judge.win?(player)
        end
      end
      :draw
    end
  end
end

# 10000回ゲームさせて、計測
p1, p2, draw = 0, 0, 0

1.upto(10000) do
  case TickTack::Game.play
  when :p1
    p1 += 1
  when :p2
    p2 += 1
  when :draw
    draw += 1
  end
end

puts "p1:#{p1}, p2:#{p2}, draw:#{draw}"
