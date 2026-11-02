local TimelinePlayer = {}
local RunService = game:GetService("RunService")

--Changes state of water and changes color
function TimelinePlayer.SetWaterState(water, state, noChangeColor, specifiedColor)
	if water:IsA("BasePart") then
		local oldColor = water.Color
		local newColor = specifiedColor
			or (string.lower(state) == "water" or state == nil) and BrickColor.new("Deep blue").Color
			or string.lower(state) == "acid" and BrickColor.new("Lime green").Color
			or string.lower(state) == "lava" and BrickColor.new("Really red").Color
		if noChangeColor ~= true then
			local tInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
			local PropTable = { Color = newColor }
			local ColorTween = game:GetService("TweenService"):Create(water, tInfo, PropTable)
			ColorTween:Play()
		end
		delay(1, function()
			local updState = water:FindFirstChild("WaterState") or water:FindFirstChild("State")
			if updState then
				updState.Value = string.lower(state)
			else
				updState = Instance.new("StringValue")
				updState.Name = "WaterState"
				updState.Parent = water
			end

			if noChangeColor ~= true then
				water.Color = newColor
			end
		end)
	end
end

--Function that moves parts and models; used primarily for floods
local InternalTweenConfigs = {}
function TimelinePlayer.MovePart(Object, Translation, Duration, IsLocalSpace, EasingStyle, EasingDirection)
	if typeof(Object) ~= "Instance" then
		error("Object: Only an Instance (Model, BasePart) can be provided")
	end
	if not (Object:IsA("Model") or Object:IsA("BasePart")) then
		error("Object: MovePart can only accept a Model with a PrimaryPart or a BasePart")
	end
	if typeof(Translation) ~= "Vector3" then
		error("Translation: Provided invalid data type (" .. typeof(Translation) .. "); please provide a Vector3 Value")
	end
	local EasingStyle, EasingDirection = EasingStyle or "Sine", EasingDirection or "InOut"
	local IsModel = Object:IsA("Model")
	if IsModel then
		if Object.PrimaryPart == nil then
			local ModelDescendants = Object:GetDescendants()
			for _, Descendant in next, ModelDescendants do
				if Descendant:IsA("BasePart") then
					Object.PrimaryPart = Descendant
					--warn("PrimaryPart not present; function has automatically assigned a PrimaryPart")
					break
				end
			end
		end
	end
	local InternalCFrameValue = Instance.new("CFrameValue")
	InternalTweenConfigs[Object] = InternalTweenConfigs[Object] or Instance.new("Configuration")
	local AttConfig = InternalTweenConfigs[Object]
	local TweenAttribute = (
		"Tween_"
			.. (IsLocalSpace and "Local" or "Global")
			.. "_"
			.. game:GetService("HttpService"):GenerateGUID(false):sub(1, 8)
	)
	AttConfig:SetAttribute(TweenAttribute, Vector3.new())
	if AttConfig:GetAttribute("OriginalCFrame") == nil then
		local refCFrame = IsModel and Object:GetPrimaryPartCFrame() or Object.CFrame
		AttConfig:SetAttribute("OriginalCFrame", refCFrame)
		AttConfig.AttributeChanged:Connect(function(ChangedAttribute)
			local AppliedCFrame = AttConfig:GetAttribute("OriginalCFrame")
			local Vectors = { ["Local"] = Vector3.new(), ["Global"] = Vector3.new() }
			for AttributeName, AttributeValue in pairs(AttConfig:GetAttributes()) do
				if AttributeName:find("Tween_") then
					for VectorName, VectorValue in pairs(Vectors) do
						if AttributeName:find(VectorName) then
							Vectors[VectorName] = Vectors[VectorName] + AttributeValue
						end
					end
				end
			end
			AppliedCFrame = AppliedCFrame * CFrame.new(Vectors.Local.X, Vectors.Local.Y, Vectors.Local.Z)
			AppliedCFrame = AppliedCFrame + Vectors.Global
			if IsModel then
				Object:PivotTo(AppliedCFrame)
			else
				Object.CFrame = AppliedCFrame
			end
		end)
	end
	InternalCFrameValue.Changed:Connect(function(NewCFrame)
		AttConfig:SetAttribute(TweenAttribute, Vector3.new(NewCFrame.X, NewCFrame.Y, NewCFrame.Z))
	end)
	local TranslationTween = game:GetService("TweenService"):Create(
		InternalCFrameValue,
		TweenInfo.new(Duration, Enum.EasingStyle[EasingStyle], Enum.EasingDirection[EasingDirection]),
		{ Value = CFrame.new(Translation.X, Translation.Y, Translation.Z) }
	)
	TranslationTween.Completed:Connect(function()
		InternalCFrameValue:Destroy()
		AttConfig:SetAttribute(TweenAttribute, nil)
		local CompleteCFrame = AttConfig:GetAttribute("OriginalCFrame")
		if IsLocalSpace then
			CompleteCFrame = CompleteCFrame * CFrame.new(Translation.X, Translation.Y, Translation.Z)
		else
			CompleteCFrame = CompleteCFrame + Translation
		end
		if IsModel then
			Object:PivotTo(CompleteCFrame)
		else
			Object.CFrame = CompleteCFrame
		end
		AttConfig:SetAttribute("OriginalCFrame", CompleteCFrame)
		local oldCFrame = IsModel and Object:GetPrimaryPartCFrame() or Object.CFrame
	end)
	TranslationTween:Play()
end

function TimelinePlayer.Motor6D(Motor : Motor6D, CFrameVal : CFrame, Tinfo)
	game.ReplicatedStorage.Remote:WaitForChild("TimelineEvents").StartMotor6D:FireAllClients(Motor, Tinfo, CFrameVal)
end

--Performs tweens on an objects properties and attributes
function TimelinePlayer.Tween(Object, PropTable, AttributeInfo, TInfo, ApplyToDescendants, ApplyRelative)
	local InternalValues =
		{ ["CFrame"] = "CFrameValue", ["number"] = "NumberValue", ["Color3"] = "Color3Value", vector3 = "Vector3Value" }
	for AttName, AttValue in next, AttributeInfo do
		if not InternalValues[typeof(AttValue)] then
			print(AttName, typeof(AttValue), "not a valid internal value type")
		else
			local NewInternalValue = Instance.new(InternalValues[typeof(AttValue)])
			local AttributeTween = game:GetService("TweenService"):Create(NewInternalValue, TInfo, { Value = AttValue })
			NewInternalValue.Value = Object:GetAttribute(AttName)
			NewInternalValue:GetPropertyChangedSignal("Value"):Connect(function()
				Object:SetAttribute(AttName, NewInternalValue.Value)
			end)
			AttributeTween.Completed:Connect(function()
				NewInternalValue:Destroy()
			end)
			AttributeTween:Play()
		end
	end
	local ObjectsToApplyTo = { Object }
	if ApplyToDescendants == true then
		for _, c in next, Object:GetDescendants() do
			table.insert(ObjectsToApplyTo, c)
		end
	end
	for _, Obj in next, ObjectsToApplyTo do
		pcall(function()
			local PropTween = game:GetService("TweenService"):Create(Obj, TInfo, PropTable)
			PropTween:Play()
		end)
	end
end

local internalValues = {
	CFrame = "CFrameValue",
	number = "NumberValue",
	Color3 = "Color3Value",
	Vector3 = "Vector3Value"
}

local tweenService = game:GetService("TweenService")
function TimelinePlayer.SetProperties(obj, properties, attributes, tInfo, applyToDescendants, relative, XFrame : ObjectValue)
	local name = obj.Name
	if name == "Settings" or name == "Rescue" then
		error(name .. " can not be accessed by SetProperties")
	end
	local Operator = XFrame:GetAttribute("Operator") :: string
	for name, value in next, attributes do
		if tInfo == 0 then
			pcall(function()
				obj:SetAttribute(name, value)
			end)
			continue
		end
		local classMapping = internalValues[typeof(value)]
		if not classMapping then
			print(name, typeof(value), "not a valid internal value type")
			continue
		end
		local final = nil
		if relative ~= nil then
			final = classMapping == "CFrameValue" and obj:GetAttribute(name) * relative or value + relative
		else
			final = value --maybe?
		end
		if Operator ~= nil then
			local prop = obj:GetAttribute(name)
			if typeof(prop) == "CFrame" then
				if Operator == "+" then
					local rx1, ry1, rz1 = prop.Rotation:ToOrientation()
					local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
					local rx2, ry2, rz2 = relative.Rotation:ToOrientation()
					local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
					--print(prop.Position + value.Position, rotation1 + rotation2)
					prop = CFrame.new(prop.Position + relative.Position, rotation1 + rotation2)
				elseif Operator == "-" then
					local r1 = prop.Rotation
					local rx1, ry1, rz1 = r1:ToOrientation()
					local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
					local r2 = relative.Rotation
					local rx2, ry2, rz2 = r2:ToOrientation()
					local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
					prop = CFrame.new(prop.Position - relative.Position, rotation1 - rotation2)
				elseif Operator == "*" then
					local r1 = prop.Rotation
					local rx1, ry1, rz1 = r1:ToOrientation()
					local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
					local r2 = relative.Rotation
					local rx2, ry2, rz2 = r2:ToOrientation()
					local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
					prop = CFrame.new(prop.Position * relative.Position, rotation1 * rotation2)
				elseif Operator == "/" then
					local r1 = prop.Rotation
					local rx1, ry1, rz1 = r1:ToOrientation()
					local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
					local r2 = relative.Rotation
					local rx2, ry2, rz2 = r2:ToOrientation()
					local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
					prop = CFrame.new(prop.Position / relative.Position, rotation1 / rotation2)
				end
			else
				if Operator == "+" then
					prop += relative
				elseif Operator == "-" then
					prop -= relative
				elseif Operator == "*" then
					prop *= relative
				elseif Operator == "/" then
					prop /= relative
				end
			end
			final = prop
		end
		local internalValue = Instance.new(classMapping)
		--internalValue.Parent = workspace
		--print(internalValue)
		local tween = tweenService:Create(internalValue, tInfo, {
			Value = final})
		internalValue.Value = obj:GetAttribute(name)
		internalValue:GetPropertyChangedSignal("Value"):Connect(function()
			obj:SetAttribute(name, internalValue.Value)
		end)
		tween.Completed:Connect(function()
			internalValue:Destroy()
		end)
		tween:Play()
	end
	local objectsToApplyTo = applyToDescendants == true and {obj, unpack(obj:GetDescendants())} or {obj}
	for i = 1, #objectsToApplyTo do
		--print(tInfo)
		if tInfo == 0 then
			for property, value in next, properties do
				pcall(function()
					if Operator ~= nil then
						local prop = objectsToApplyTo[property] :: CFrame | any
						if typeof(prop) == "CFrame" then
							if Operator == "+" then
								local rx1, ry1, rz1 = prop.Rotation:ToOrientation()
								local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
								local rx2, ry2, rz2 = value.Rotation:ToOrientation()
								local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
								--print(prop.Position + value.Position, rotation1 + rotation2)
								prop = CFrame.new(prop.Position + value.Position, rotation1 + rotation2)
							elseif Operator == "-" then
								local r1 = prop.Rotation
								local rx1, ry1, rz1 = r1:ToOrientation()
								local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
								local r2 = value.Rotation
								local rx2, ry2, rz2 = r2:ToOrientation()
								local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
								prop = CFrame.new(prop.Position - value.Position, rotation1 - rotation2)
							elseif Operator == "*" then
								local r1 = prop.Rotation
								local rx1, ry1, rz1 = r1:ToOrientation()
								local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
								local r2 = value.Rotation
								local rx2, ry2, rz2 = r2:ToOrientation()
								local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
								prop = CFrame.new(prop.Position * value.Position, rotation1 * rotation2)
							elseif Operator == "/" then
								local r1 = prop.Rotation
								local rx1, ry1, rz1 = r1:ToOrientation()
								local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
								local r2 = value.Rotation
								local rx2, ry2, rz2 = r2:ToOrientation()
								local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
								prop = CFrame.new(prop.Position / value.Position, rotation1 / rotation2)
							end
						else
							if Operator == "+" then
								prop += value
							elseif Operator == "-" then
								prop -= value
							elseif Operator == "*" then
								prop *= value
							elseif Operator == "/" then
								prop /= value
							end
						end
						objectsToApplyTo[property] = prop
					else
						local prop = objectsToApplyTo[property]
						print(prop, value, prop + value)
						objectsToApplyTo[property] = typeof(prop) == "CFrame" and prop * value or prop + value 
					end
				end)
			end
		else
			local properties = properties
			if relative then
				properties = table.clone(properties)
				for property, value in next, properties do
					pcall(function()
						if Operator ~= nil then
							local prop = objectsToApplyTo[property]
							if typeof(prop) == "CFrame" then
								if Operator == "+" then
									local rx1, ry1, rz1 = prop.Rotation:ToOrientation()
									local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
									local rx2, ry2, rz2 = value.Rotation:ToOrientation()
									local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
									--print(prop.Position + value.Position, rotation1 + rotation2)
									prop = CFrame.new(prop.Position + value.Position, rotation1 + rotation2)
								elseif Operator == "-" then
									local r1 = prop.Rotation
									local rx1, ry1, rz1 = r1:ToOrientation()
									local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
									local r2 = value.Rotation
									local rx2, ry2, rz2 = r2:ToOrientation()
									local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
									prop = CFrame.new(prop.Position - value.Position, rotation1 - rotation2)
								elseif Operator == "*" then
									local r1 = prop.Rotation
									local rx1, ry1, rz1 = r1:ToOrientation()
									local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
									local r2 = value.Rotation
									local rx2, ry2, rz2 = r2:ToOrientation()
									local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
									prop = CFrame.new(prop.Position * value.Position, rotation1 * rotation2)
								elseif Operator == "/" then
									local r1 = prop.Rotation
									local rx1, ry1, rz1 = r1:ToOrientation()
									local rotation1 = Vector3.new(math.deg(rx1), math.deg(ry1),math.deg(rz1))
									local r2 = value.Rotation
									local rx2, ry2, rz2 = r2:ToOrientation()
									local rotation2 = Vector3.new(math.deg(rx2), math.deg(ry2),math.deg(rz2))
									prop = CFrame.new(prop.Position / value.Position, rotation1 / rotation2)	
								end
							else
								if Operator == "+" then
									prop += value
								elseif Operator == "-" then
									prop -= value
								elseif Operator == "*" then
									prop *= value
								elseif Operator == "/" then
									prop /= value
								end
							end
							objectsToApplyTo[property] = prop
							--print(objectsToApplyTo[property])
						else
							local prop = objectsToApplyTo[property]
							objectsToApplyTo[property] = typeof(prop) == "CFrame" and prop * value or prop + value
						end
					end)
				end
			end
		end
		pcall(function()
			if tInfo == 0 then
				for name, value in next, properties do
					objectsToApplyTo[i][name] = value
				end
			else
				tweenService:Create(objectsToApplyTo[i], tInfo, properties):Play()
			end
		end)
	end
end

--Plays a sound in the map
function TimelinePlayer.Sound(Object, ID, Volume, Pitch)
	local NewSound = Instance.new("Sound")
	NewSound.SoundId = "rbxassetid://" .. ID
	NewSound.Volume = Volume
	NewSound.Pitch = Pitch
	NewSound.Parent = Object or script.Parent
	NewSound:Play()
end

function TimelinePlayer.Alert(Message, Color, Duration)
	if RunService:IsServer() then
		game.ReplicatedStorage.Remote.Alert:FireAllClients(Message, Color, Duration)
		return	
	end
end

function TimelinePlayer.ShakeCamera(Intensity, Length)
	game.ReplicatedStorage.Remote.TimelineEvents.Shake:FireAllClients(Intensity, Length)	
end

--Teleports players
function TimelinePlayer.Teleport(Destination, Player)
	local PlayersToTele = Player and { Player } or {game.ServerStorage.Bindables.GetPlaying:Invoke()}
	--print(PlayersToTele)
	for PlayerName, PlayerObject in pairs(PlayersToTele) do
		if PlayerObject.Character and PlayerObject.Character:FindFirstChild("HumanoidRootPart") then
			PlayerObject.Character.HumanoidRootPart.CFrame = Destination.CFrame
		end
	end
end

--Sets information for camera manipulation
function TimelinePlayer.SetCamera(Subject, Enabled, CamInfo, RelativeToSubject, DisableOnEnd, Length)
	game.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("TimelineEvents").SetCam:FireAllClients(Subject, Enabled, CamInfo, RelativeToSubject, DisableOnEnd, Length)
end

--Set humanoid logic
function TimelinePlayer.SetHumanoid(Properties)
	for _, item in pairs(Properties) do
		if item["AttributeName"] and item["Value"] then
			local players = game.ServerStorage.Bindables.GetPlaying:Invoke() --ur way of getting players
			for _, plr in pairs(players) do
				if item["AttributeName"] == "Jump" then
					plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
				plr.Character.Humanoid[item["AttributeName"]] = item["Value"]
			end
		else
			--warn("No Properties found in XFrame?")
		end
	end
end

--Function Wrapper For Timeline Execution
function TimelinePlayer.PerformXFrame(MapModel, XFrame, Player)
	local Function, Position, Length =
		XFrame:GetAttribute("XFrame_Function"),
		XFrame:GetAttribute("XFrame_Timestamp"),
		XFrame:GetAttribute("XFrame_Length")
	if not Function or typeof(Function) ~= "string" then
		error("XFrame " .. XFrame.Name .. " contains invalid function")
	end
	if not Position or typeof(Position) ~= "number" then
		error("XFrame " .. XFrame.Name .. " contains invalid Timestamp")
	end
	if not Length or typeof(Length) ~= "number" then
		Length = 0
	end
	if Function == "SetProperties" then
		if XFrame.Value then
			local AllAttributes = XFrame:GetAttributes()
			local PropTable = {}
			local AttributeTable = {}
			local IsTweenFunction = false
			local IsMotor6D_Function = false
			local Motor6DCFrames = nil
			for Name, Value in pairs(AllAttributes) do
				if string.find(Name, "Property_") then
					if string.sub(Name, 10) == "Transform" then
						Motor6DCFrames = Value
					else
						PropTable[string.sub(Name, 10)] = Value
					end
				end
				if string.find(Name, "Attribute_") then
					AttributeTable[string.sub(Name, 11)] = Value
					--print(AttributeTable)
				end
			end
			for Name2, Value2 in pairs(AllAttributes) do
				if string.find(Name2, "Tween_") then
					IsTweenFunction = true
				end
			end
			if Motor6DCFrames ~= nil then
				IsMotor6D_Function = true
			end
			if IsMotor6D_Function then
				--cool?
				local oh = XFrame:Clone() :: Configuration?
				oh.Parent = XFrame.Value
				local TInfo = TweenInfo.new(
					Length,
					Enum.EasingStyle[XFrame:GetAttribute("Tween_EasingStyle") or "Sine"],
					Enum.EasingDirection[XFrame:GetAttribute("Tween_EasingDirection") or "InOut"],
					XFrame:GetAttribute("Tween_RepeatCount") or 0,
					XFrame:GetAttribute("Tween_Reverses") or false,
					XFrame:GetAttribute("Tween_DelayTime") or 0
				)
				TimelinePlayer.Motor6D(
					XFrame.Value,
					Motor6DCFrames,
					oh
				)
			else
				local arguments = {
					XFrame.Value,
					PropTable,
					AttributeTable,
					0,
					XFrame:GetAttribute("XFrame_ApplyToDescendants") or XFrame:GetAttribute("ApplyToDescendants"),
					XFrame:GetAttribute("ApplyRelative"),
					XFrame
				}
				if IsTweenFunction then
					arguments[4] = TweenInfo.new(
						Length,
						Enum.EasingStyle[XFrame:GetAttribute("Tween_EasingStyle") or "Sine"],
						Enum.EasingDirection[XFrame:GetAttribute("Tween_EasingDirection") or "InOut"],
						XFrame:GetAttribute("Tween_RepeatCount") or 0,
						XFrame:GetAttribute("Tween_Reverses") or false,
						XFrame:GetAttribute("Tween_DelayTime") or 0
					)
				end
				TimelinePlayer.SetProperties(unpack(arguments))
			end
		end
		return
	end
	if Function == "SetWaterState" then
		if XFrame.Value then
			TimelinePlayer.SetWaterState(
				XFrame.Value,
				XFrame:GetAttribute("State"),
				XFrame:GetAttribute("DontChangeColor"),
				XFrame:GetAttribute("SpecifiedColor")
			)
		end
		return
	end
	if Function == "MovePart" then
		if XFrame.Value then
			TimelinePlayer.MovePart(
				XFrame.Value,
				XFrame:GetAttribute("Translation"),
				Length,
				XFrame:GetAttribute("UseLocalSpace") or false,
				XFrame:GetAttribute("EasingStyle"),
				XFrame:GetAttribute("EasingDirection")
			)
		end
		return
	end
	if Function == "Alert" then
		TimelinePlayer.Alert(XFrame:GetAttribute("Message"), XFrame:GetAttribute("Color"), Length)
		return
	end
	if Function == "Sound" then
		TimelinePlayer.Sound(
			XFrame.Value,
			XFrame:GetAttribute("SoundId"),
			XFrame:GetAttribute("Volume") or 1,
			XFrame:GetAttribute("Pitch") or 1
		)
		return
	end
	if Function == "ShakeCamera" then
		TimelinePlayer.ShakeCamera(XFrame:GetAttribute("Intensity"), Length)
		return
	end
	if Function == "Teleport" then
		TimelinePlayer.Teleport(XFrame.Value, Player)
		return
	end
	if Function == "SetCamera" then
		TimelinePlayer.SetCamera(
			XFrame.Value,
			XFrame:GetAttribute("Enabled"),
			XFrame:GetAttribute("CamInfo"),
			XFrame:GetAttribute("RelativeToSubject"),
			XFrame:GetAttribute("DisableOnEnd"),
			XFrame:GetAttribute("XFrame_Length")
		)
		return
	end
	if Function == "SetHumanoid" then
		local Attributes = {}
		for AttributeName, Any in pairs(XFrame:GetAttributes()) do
			if AttributeName ~= "XFrame_Function" and AttributeName ~= "XFrame_Length" and AttributeName ~= "XFrame_Priority" and AttributeName ~= "XFrame_Timestamp" and string.find(AttributeName, "Property_") then
				local var = AttributeName:split(string.sub(AttributeName, 1, string.find(AttributeName, "_")))
				table.insert(Attributes, {
					AttributeName = var[2],
					Value = Any
				})
			end
		end
		TimelinePlayer.SetHumanoid(Attributes)
	end
end
return TimelinePlayer