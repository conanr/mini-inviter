module EventsHelper
  def display_restaurant_names(event)
    event.restaurant_options.collect { |ro| ro.restaurant.name }.join(", ")
  end
end