require 'roda'
require 'active_support/inflector'
require 'active_support/version'

class App < Roda

  INFLECTIONS = ActiveSupport::Inflector.instance_methods.sort
  INDEXES = {
    :first_end => INFLECTIONS.length.odd? ? INFLECTIONS.length / 2 + 1 : INFLECTIONS.length / 2,
    :second_start => INFLECTIONS.length.odd? ? INFLECTIONS.length - INFLECTIONS.length / 2 - 1 : INFLECTIONS.length - INFLECTIONS.length / 2
  }

  plugin :render, :engine => 'slim'

  route do |r|

    r.root do
      @text = 'foo bar'
      render :index
    end

    r.on :all do |text|
      @text = CGI.unescape(r.path[1..-1])
      render :index
    end

  end

end

run App.freeze.app
