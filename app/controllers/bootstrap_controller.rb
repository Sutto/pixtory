class BootstrapController < ApplicationController

  def create
    person = Person.new(params[:push_token])
    if person.save
      render json: person, status: :created, personal: true
    else
      render json: person, status: :unprocessible_entity
    end
  end

end
