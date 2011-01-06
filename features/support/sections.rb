module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
    when /body/
      "html > body"

    when /(notice|error|info) flash/
      ".flash.#{$1}"

    when /user nav/
      "nav.user"

    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)
