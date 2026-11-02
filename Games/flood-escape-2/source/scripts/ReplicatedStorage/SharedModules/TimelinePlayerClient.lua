local TimelinePlayer = {}

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

--Instantly sets the properties or attributes of an object
function TimelinePlayer.SetProperties(Object, PropTable, AttributeTable, ApplyToDescendants, ApplyRelative)
	if Object.Name == "Settings" or Object.Name == "Rescue" then
		error(Object.Name .. " can not be accessed by SetProperties")
	end
	if Object.Name ~= "Settings" and Object.Name ~= "Rescue" then
		for AttName, AttValue in next, AttributeTable do
			Object:SetAttribute(AttName, AttValue)
		end
	end
	local ObjectsToApplyTo = { Object }
	if ApplyToDescendants == true then
		for _, c in next, Object:GetDescendants() do
			table.insert(ObjectsToApplyTo, c)
		end
	end
	for _, Obj in next, ObjectsToApplyTo do
		for Name, Value in pairs(PropTable) do
			pcall(function()
				Obj[Name] = Value
			end)
		end
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
	game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript.Alert:Fire(Message, Color, Duration)
end

function TimelinePlayer.ShakeCamera(Intensity, Length)
	game.ReplicatedStorage.Remote.TimelineEvents.ShakeBind:Invoke(Intensity, Length)
end

--Teleports players
function TimelinePlayer.Teleport(Destination, Player)
	local PlayersToTele = Player and { Player } or {game.Players.LocalPlayer}
	for PlayerName, PlayerObject in pairs(PlayersToTele) do
		if PlayerObject == game.Players.LocalPlayer then
			if PlayerObject.Character and PlayerObject.Character:FindFirstChild("HumanoidRootPart") then
				PlayerObject.Character.HumanoidRootPart.CFrame = Destination.CFrame
			end
		end
	end
end

--Sets information for camera manipulation
function TimelinePlayer.SetCamera(Subject, Enabled, CamInfo, RelativeToSubject, DisableOnEnd, Length)
	game.ReplicatedStorage:WaitForChild("Remote").TimelineEvents.SetCamBind:Invoke(Subject, Enabled, CamInfo, RelativeToSubject, DisableOnEnd, Length)
end

--Set humanoid logic
function TimelinePlayer.SetHumanoid(Properties)
	for _, item in pairs(Properties) do
		if item["AttributeName"] and item["Value"] then
			local plr = game.Players.LocalPlayer
			if item["AttributeName"] == "Jump" then
				plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
			plr.Character.Humanoid[item["AttributeName"]] = item["Value"]
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