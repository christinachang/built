module ProjectsHelper

  def short_description(text)
    truncate(text, :length => 150, :separator => ' ')
  end

end

