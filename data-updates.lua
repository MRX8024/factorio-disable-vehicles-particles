local function disable_vehicle_particles(vehicle)
    if not vehicle then return end
    vehicle.light_animation = nil
    vehicle.light = nil
    vehicle.track_particle_triggers = nil
    vehicle.smoke = nil
    vehicle.dying_explosion = nil
    vehicle.destroy_action = nil
    vehicle.collision_trigger_effect = nil
    vehicle.collision_trigger_effects = nil
    if vehicle.energy_source and vehicle.energy_source.smoke then
        vehicle.energy_source.smoke = nil
    end
    for _, trigger_name in pairs({"start_trigger", "stop_trigger"}) do
        local triggers = vehicle[trigger_name]
        if triggers then
            local cleaned = {}
            for _, t in pairs(triggers) do
                if t.type ~= "create-trivial-smoke" and t.type ~= "create-particle" then
                    table.insert(cleaned, t)
                end
            end
            vehicle[trigger_name] = (#cleaned > 0) and cleaned or nil
        end
    end
end
  
  for _, proto_type in pairs({"car", "locomotive", "cargo-wagon", "fluid-wagon", "artillery-wagon", "spider-vehicle"}) do
    for name, vehicle in pairs(data.raw[proto_type] or {}) do
        disable_vehicle_particles(vehicle)
    end
  end
