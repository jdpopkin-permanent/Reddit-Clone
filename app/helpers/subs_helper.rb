module SubsHelper

  def links_from_params(parameters)
    links = []

    parameters[:links].each do |key, value|
      value.each do |key2, value2|
        if value2 && value2 != ""
          links << Link.new(value)
          break
        end
      end
    end

    links
  end
end
