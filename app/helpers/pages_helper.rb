module PagesHelper
  def get_profile_letters(name)
    name.split[-2..-1].map {|word| word[0]}.join
  end
end
