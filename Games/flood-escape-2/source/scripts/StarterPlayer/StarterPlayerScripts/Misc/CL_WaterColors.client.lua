--[[
FE2 code lol
--]]
local Active = false
local RandomColor = false
local CL_MAIN_GameScript = script.Parent.Parent.CL_MAIN_GameScript
local Color_Water = game.ReplicatedStorage.Config.RandomFloodColors:GetAttribute("water")
local Color_Acid = game.ReplicatedStorage.Config.RandomFloodColors:GetAttribute("acid")
local Color_Lava = game.ReplicatedStorage.Config.RandomFloodColors:GetAttribute("lava")
--Contains tables that say what properties are colours that should be changed
local classColorPropNames = {
	["BasePart"] = {"Color"},
	["Light"] = {"Color"},
	["Smoke"] = {"Color"},
	["Trail"] = {"Color"},
	["ParticleEmitter"] = {"Color"},
	["Beam"] = {"Color"},
	["Decal"] = {"Color3"},
	["Texture"] = {"Color3"},
	["Fire"] = {"Color", "SecondaryColor"},
	["Sparkles"] = {"SparklesColor"},
	["ImageLabel"] = {"ImageColor3"}
}

--This function returns specific color value types, otherwise it returns the original Color3
local function getColorVal(color3, propType)
	if propType == "ColorSequence" then
		if typeof(color3) == "table" then
			return ColorSequence.new{ ColorSequenceKeypoint.new(0, color3[1]), ColorSequenceKeypoint.new(1, color3[1]) }
		else
			return ColorSequence.new{ ColorSequenceKeypoint.new(0, color3), ColorSequenceKeypoint.new(1, color3) }
		end
	end

	return color3
end

--This function iterates through any applicable property the object has to change color, then applies the correct color type
local function changeColorBasedOnClass(obj, color3)
	if string.find(obj.ClassName, "Part") or string.find(obj.ClassName, "part") then
		for _, property in next, classColorPropNames["BasePart"] do
			local t = {[tostring(property)] = getColorVal(color3, typeof(obj[property]))}
			game:GetService("TweenService"):Create(obj, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), t):Play()
			--obj[property] = getColorVal(color3, typeof(obj[property]))
		end
	else
		for _, property in next, classColorPropNames[obj.ClassName] do
			local t = {[tostring(property)] = getColorVal(color3, typeof(obj[property]))}
			game:GetService("TweenService"):Create(obj, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), t):Play()
		end
	end
end

--disgusting event
script.InitMap.Event:Connect(function()
	if CL_MAIN_GameScript.GetPlayerData:Invoke().Passes.CFC and Active then
		if RandomColor == true then
			Color_Water = Color3.fromRGB(math.random(1, 255), math.random(1, 255), math.random(1, 255))
			Color_Acid = Color3.fromRGB(math.random(1, 255), math.random(1, 255), math.random(1, 255))
			Color_Lava = Color3.fromRGB(math.random(1, 255), math.random(1, 255), math.random(1, 255))	
		end
		local Map = workspace.Multiplayer:WaitForChild("Map") :: Model
		for index, item in ipairs(Map:GetDescendants()) do
			if item.Name == "_LinkColor" and item:IsA("ObjectValue") then
				local obj = item.Value
				if string.sub(obj.Name, 1, 6) == "_Water" then
					local State = obj:FindFirstChild("WaterState") or obj:FindFirstChild("State") :: StringValue
					if State ~= nil then
						if State.Value == "water" then
							local color = Color_Water
							changeColorBasedOnClass(obj,color)
						elseif State.Value == "acid" then
							local color = Color_Acid
							changeColorBasedOnClass(obj,color)
						elseif State.Value == "lava" then
							local color = Color_Acid
							changeColorBasedOnClass(obj,color)
						end
					else
						local color = Color_Water
						changeColorBasedOnClass(obj,color)
					end
					if State ~= nil then
						State.Changed:Connect(function(newValue : string)
							local plr_state = CL_MAIN_GameScript.GetPlayerData:Invoke().PlayerState
							if plr_state == "Playing" then
								local State = newValue
								if State ~= nil then
									if State == "water" then
										local color = Color_Water
										changeColorBasedOnClass(obj,color)
									elseif State == "acid" then
										local color = Color_Acid
										changeColorBasedOnClass(obj,color)
									elseif State == "lava" then
										local color = Color_Lava
										changeColorBasedOnClass(obj,color)
									end
								else
									local color = Color_Water
									changeColorBasedOnClass(obj,color)
								end
							end
						end)
					else
						repeat task.wait() until obj:FindFirstChild("WaterState") or obj:FindFirstChild("State")
						if State ~= nil then
							if State == "water" then
								local color = Color_Water
								changeColorBasedOnClass(obj,color)
							elseif State == "acid" then
								local color = Color_Acid
								changeColorBasedOnClass(obj,color)
							elseif State == "lava" then
								local color = Color_Lava
								changeColorBasedOnClass(obj,color)
							end
						else
							local color = Color_Water
							changeColorBasedOnClass(obj,color)
						end
						State.Changed:Connect(function(newValue : string)
							local plr_state = CL_MAIN_GameScript.GetPlayerData:Invoke().PlayerState
							if plr_state == "Playing" then
								local State = newValue
								if State ~= nil then
									if State == "water" then
										local color = Color_Water
										changeColorBasedOnClass(obj,color)
									elseif State == "acid" then
										local color = Color_Acid
										changeColorBasedOnClass(obj,color)
									elseif State == "lava" then
										local color = Color_Lava
										changeColorBasedOnClass(obj,color)
									end
								else
									local color = Color_Water
									changeColorBasedOnClass(obj,color)
								end
							end
						end)
					end
				else
					local idk_if_this_works = {
						Color_Water,
						Color_Acid,
						Color_Lava
					}
					local random = idk_if_this_works[math.random(1, 3)]
					changeColorBasedOnClass(obj, idk_if_this_works)
				end
			elseif string.sub(item.Name, 1, 6) == "_Water" then
				local State = item:FindFirstChild("WaterState") or item:FindFirstChild("State")
				if State ~= nil then
					if State.Value == "water" then
						local color = Color_Water
						changeColorBasedOnClass(item,color)
					elseif State.Value == "acid" then
						local color = Color_Acid
						changeColorBasedOnClass(item,color)
					elseif State.Value == "lava" then
						local color = Color_Acid
						changeColorBasedOnClass(item,color)
					end
				else
					local color = Color_Water
					changeColorBasedOnClass(item,color)
				end
				if State ~= nil then
					State.Changed:Connect(function(newValue : string)
						local plr_state = CL_MAIN_GameScript.GetPlayerData:Invoke().PlayerState
						if plr_state == "Playing" then
							local State = newValue
							if State ~= nil then
								if State == "water" then
									local color = Color_Water
									changeColorBasedOnClass(item,color)
								elseif State == "acid" then
									local color = Color_Acid
									changeColorBasedOnClass(item,color)
								elseif State == "lava" then
									local color = Color_Lava
									changeColorBasedOnClass(item,color)
								end
							else
								local color = Color_Water
								changeColorBasedOnClass(item,color)
							end
						end
					end)
				else
					repeat task.wait() until item:FindFirstChild("WaterState") or item:FindFirstChild("State")
					if State ~= nil then
						if State == "water" then
							local color = Color_Water
							changeColorBasedOnClass(item,color)
						elseif State == "acid" then
							local color = Color_Acid
							changeColorBasedOnClass(item,color)
						elseif State == "lava" then
							local color = Color_Lava
							changeColorBasedOnClass(item,color)
						end
					else
						local color = Color_Water
						changeColorBasedOnClass(item,color)
					end
					State.Changed:Connect(function(newValue : string)
						local plr_state = CL_MAIN_GameScript.GetPlayerData:Invoke().PlayerState
						if plr_state == "Playing" then
							local State = newValue
							if State ~= nil then
								if State == "water" then
									local color = Color_Water
									changeColorBasedOnClass(item,color)
								elseif State == "acid" then
									local color = Color_Acid
									changeColorBasedOnClass(item,color)
								elseif State == "lava" then
									local color = Color_Lava
									changeColorBasedOnClass(item,color)
								end
							else
								local color = Color_Water
								changeColorBasedOnClass(item,color)
							end
						end
					end)
				end
			end
		end
	end
end)

script.UpdCustomColors.Event:Connect(function(colorTable, boolean1, boolean2, themeName)
	--print(colorTable, boolean1, boolean2, themeName)
	Active = boolean1
	RandomColor = boolean2
	if RandomColor then
		return
		--CL_MAIN_GameScript.Notify:Fire("Info", "Random Colors is still WIP. Which means it isn't out yet sorry!", nil, false)
	end
	game.ReplicatedStorage.Config.RandomFloodColors:SetAttribute("acid", colorTable.acid)
	game.ReplicatedStorage.Config.RandomFloodColors:SetAttribute("water", colorTable.water)
	game.ReplicatedStorage.Config.RandomFloodColors:SetAttribute("lava", colorTable.lava)
	Color_Water = game.ReplicatedStorage.Config.RandomFloodColors:GetAttribute("water")
	Color_Acid = game.ReplicatedStorage.Config.RandomFloodColors:GetAttribute("acid")
	Color_Lava = game.ReplicatedStorage.Config.RandomFloodColors:GetAttribute("lava")	
end)