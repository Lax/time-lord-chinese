# -*- encoding: utf-8 -*-
require 'time'

class Time
  Second     = 1
  Minute     = Second  * 60
  Hour       = Minute  * 60
  Day        = Hour    * 24
  Week       = Day     * 7
  Fortnight  = Week    * 2
  Month      = Week    * 4
  Quarter    = Month   * 3
  Year       = Month   * 12
  Olympiad   = Year    * 4
  Lustrum    = Year    * 5
  Decade     = Year    * 10
  Indiction  = Year    * 15
  Jubilee    = Decade  * 5
  Century    = Decade  * 10
  Millennium = Century * 10
  TenMillennium = Millennium * 10
  Eon        = 1.0/0

  def ago_in_words
    # Find the time difference between the time provided and the current time.
    difference = get_time_difference_from self

    # Catch less than 1 second differences.
    return "现在" if (-1...1) === difference

    name   = get_unit_name_from difference
    amount = get_unit_amount_from difference
    count  = get_unit_count_from(difference, amount).abs

    # Return the remaining string.
    difference >= 0 ? "#{count}#{name}前" : "#{count}#{name}后"
  end

  private

  def get_time_difference_from time
    Time.now.to_i - time.to_i
  end

  def get_unit_count_from difference, amount
    difference / amount
  end

  def get_unit_name_from difference
    case difference.abs
      when Second...Minute      then "秒"
      when Minute...Hour        then "分钟"
      when Hour...Day           then "小时"
      when Day...Week           then "天"
      when Week...Month         then "周"
      when Month...Year         then "个月"
      when Year..Decade         then "年"
      when Decade...Century     then "年"
      when Century...Millennium then "世纪"
      when Millennium...TenMillennium   then "千年"
      when TenMillennium...Eon     then "万年"
    end
  end

  def get_unit_amount_from difference
    case difference.abs
      when Second...Minute      then Second
      when Minute...Hour        then Minute
      when Hour...Day           then Hour
      when Day...Week           then Day
      when Week...Month         then Week
      when Month...Year         then Month
      when Year..Decade         then Year
      when Decade...Century     then Year
      when Century...Millennium then Century
      when Millennium...TenMillennium   then Millennium
      when TenMillennium...Eon     then TenMillennium
    end
  end

  alias_method :time_ago_in_words, :ago_in_words
  alias_method :distance_in_words, :ago_in_words
  alias_method :time_distance_in_words, :ago_in_words
end
