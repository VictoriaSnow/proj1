class PokemonsController < ApplicationController
#   def index
#     @pokemons = Pokemon.all
#   end
  def capture
    @pokemon = Pokemon.find params[:id]
    @pokemon.trainer = current_trainer
    @pokemon.save
    redirect_to root_path 
  end
  def damage
    @pokemon = Pokemon.find params[:id]
    @pokemon.health -= 10
    @pokemon.save
    redirect_to trainer_path(current_trainer)
    if @pokemon.health <= 0
      @pokemon.destroy
    end
  end
  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.health=100
    @pokemon.level=1
    @pokemon.trainer=current_trainer
    @didSave=@pokemon.save
    if @didSave==true
      redirect_to current_trainer
    else
      flash[:error]=pokemon.errors.full_messages.to_sentence
      redirect_to new_pokemon_path
    end
  end
  def heal
    @pokemon=Pokemon.find(params[:id])
    @pokemon.health+=10
    @pokemon.save
    redirect_to trainer_path(@pokemon.trainer_id)
  end
  private
  def pokemon_params
    params.require(:pokemon).permit(:name)
  end

end