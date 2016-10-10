json.thermostat do
  json.uuid @thermostat.uuid

  json.temperature do
    json.value @thermostat.temperature.value
    json.scale @thermostat.temperature.scale
  end

  json.humidity do
    json.value @thermostat.humidity.value
    json.scale @thermostat.humidity.scale
  end
end
