require "rails_helper"

# User Story 1, Plots Index Page
# As a visitor
# When I visit the plots index page ('/plots')
# I see a list of all plot numbers
# And under each plot number I see names of all that plot's plants

RSpec.describe Plot do
  it "has plot numbers that each have all of the plot's plants" do
    garden = Garden.create!(name: 'My garden', organic: false)
    plot_1 = Plot.create!(number: 1, size: "big", direction: "west", garden_id: garden.id)
    plot_2 = Plot.create!(number: 2, size: "big", direction: "west", garden_id: garden.id)
    plant_1 = Plant.create!(name: "Ted", description: "A plant", days_to_harvest: 4)
    plant_2 = Plant.create!(name: "Bob", description: "A plant", days_to_harvest: 4)
    plant_3 = Plant.create!(name: "yolo", description: "A plant", days_to_harvest: 4)
    plant_4 = Plant.create!(name: "tomato", description: "A plant", days_to_harvest: 4)
    PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_1.id)
    PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_2.id)
    PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_3.id)
    PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_4.id)

    visit '/plots'

    expect(page).to have_content(plot_1.number)
    expect(page).to have_content(plot_2.number)
    expect(page).to have_content("All plots")
    expect(page).to have_content(plant_1.name)
    expect(page).to have_content(plant_2.name)
    expect(page).to have_content(plant_3.name)
    expect(page).to have_content(plant_4.name)
  end

#   User Story 2, Remove a Plant from a Plot
# As a visitor
# When I visit a plot's index page
# Next to each plant's name
# I see a link to remove that plant from that plot
# When I click on that link
# I'm returned to the plots index page
# And I no longer see that plant listed under that plot
# (Note: you should not destroy the plant record entirely)

  it "can remove a plant from a plot" do
    garden = Garden.create!(name: 'My garden', organic: false)
    plot_1 = Plot.create!(number: 1, size: "big", direction: "west", garden_id: garden.id)
    plot_2 = Plot.create!(number: 2, size: "big", direction: "west", garden_id: garden.id)
    plant_1 = Plant.create!(name: "Ted", description: "A plant", days_to_harvest: 4)
    plant_2 = Plant.create!(name: "Bob", description: "A plant", days_to_harvest: 4)
    plant_3 = Plant.create!(name: "yolo", description: "A plant", days_to_harvest: 4)
    plant_4 = Plant.create!(name: "tomato", description: "A plant", days_to_harvest: 4)
    PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_1.id)
    PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_2.id)
    PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_3.id)
    PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_4.id)

    visit '/plots'

    expect(page).to have_content("Ted")
    expect(page).to have_link("remove #{plant_1.name}")

    click_on "remove #{plant_1.name}"

    expect(current_path).to eq('/plants')
    expect(page).not_to have_content(plant_1.name)
  end
end
