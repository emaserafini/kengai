class ThermostatStatusManager
  attr_reader :thermostat

  def initialize thermostat
    @thermostat = thermostat
  end

  def refresh
    thermostat.update_attributes status: status
  end

  def status
    return :standby unless thermostat.enabled?
    return :unknown unless thermostat.temperature.value
    return :heating if thermostat.active? && ((Time.now - thermostat.started_at < thermostat.minimum_run.minutes) || target_temperature_range.include?(thermostat.temperature.value))
    temperatures_check
  end

  def target_temperature_range
    (thermostat.program.target_temperature - thermostat.offset_temperature..thermostat.program.target_temperature + thermostat.offset_temperature)
  end

  def temperatures_check
    thermostat.temperature.value <= thermostat.program.target_temperature ? :heating : :standby
  end
end
