module ProjectsHelper

  def short_description(text)
    truncate(text, :length => 250, :separator => ' ')
  end

end

