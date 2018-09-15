require_relative 'message'
require_relative 'menu'

class Takeaway
  attr_reader :menu

  def initialize
    @menu = {
      "pelmeni" => 6.99, "borscht" => 4.99, 
      "salat" => 5.99, "olivier" => 9.99, 
      "tvarog" => 2.99, "smetyana" => 1.99
    }
    @order_total = []
  end

  def order(food_choice, quantity = 1)
    raise "Sorry, we don't have that item." unless @menu.include? food_choice
    calculate_total(food_choice, quantity)
    "#{quantity}x - #{food_choice.capitalize} added to basket."
  end

  def order_total
    "£#{@order_total.sum}"
  end

  def order_confirmation(message = Message.new)
    time = Time.now + 3600
    message.send_text("Spasibo! Your total is #{order_total}. It will be there by #{time.strftime("%H:%M")}.")
    "Confirmed."
  end

  private

  def calculate_total(food_choice, quantity)
    @menu.each do |food, price|
      if food_choice == food
        @order_total << (price * quantity)
      end
    end
  end

end
