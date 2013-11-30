
-- Command "/blowvehiclesinwater" - blow all not blowned vehicles in water
function blowVehiclesInWater(thePlayer, command)

	if not hasObjectPermissionTo(thePlayer, "command.vehicles", false) then
        outputChatBox ( "У тебя нет доступа к данной команде.", sourcePlayer )
        return false
    end

	-- get all vehicles
	for k, v in ipairs( getElementsByType("vehicle") ) do
		-- is vehicle in water and not blown?
		if isElementInWater( v ) and not isVehicleBlown( v ) then
			-- then blow
			blowVehicle( v, false)
		end
	end
end
addCommandHandler("blowvehiclesinwater", blowVehiclesInWater)

function spawnVehicle(thePlayer, command, ...)
	if not hasObjectPermissionTo(thePlayer, "command.vehicles", false) then
        outputChatBox ( "У тебя нет доступа к данной команде.", sourcePlayer )
        return false
    end
	
	if ( sourcePlayer ) then
      -- calculate the position of the vehicle based on the player's position and rotation:
      local x, y, z = getElementPosition ( sourcePlayer ) -- get the player's position
      local rotZ = getPedRotation ( sourcePlayer ) -- get the player's rotation around the Z axis in degrees
      x = x + ( ( math.cos ( math.rad ( rotZ ) ) ) * distance ) -- calculate the X position of the vehicle
      y = y + ( ( math.sin ( math.rad ( rotZ ) ) ) * distance ) -- calculate the Y position of the vehicle
 
      -- get the complete vehicle name by joining all passed parameters using Lua function table.concat
      local vehicleName = table.concat({...}, " ")
      -- get the vehicle's model ID from the name
      local vehicleID = getVehicleModelFromName ( vehicleName )
      -- if vehicle ID is valid,
      if vehicleID then
            -- create the vehicle using the information gathered above:
            local newVehicle = createVehicle ( vehicleID, x, y, z, 0, 0, rotZ )
            -- if vehicle creation failed, give the player a message
            if not newVehicle then
               outputChatBox ( "Ошибка создания автомобиля", thePlayer )
            end
      end
   end
end