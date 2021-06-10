# frozen_string_literal: true

module Counter
  private

  def count_visit
    session[:counter] ||= 0
    session[:counter] += 1
  end

  def counter
    session[:counter]
  end

  def reset_counter
    session[:counter] = 0
  end
end

