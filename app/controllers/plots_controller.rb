class PlotsController < ApplicationController
  def index

    @plots = Plot.all
  end

  def destroy

    plot = Plot.find(params[:id])
    plant_plot = plot.plant_plots.where('plant_id=?', params[:plant_id]).first
    plant_plot.destroy
    require "pry"; binding.pry
  end
end
