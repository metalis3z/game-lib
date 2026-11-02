--credit to leon games studio
local Zone = require(game.ReplicatedStorage.SharedModules.Zone)
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = game.Players.LocalPlayer
local WeatherMachineData = game.ReplicatedStorage.ServerValues.WeatherMachineData
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local SoundService = game:GetService("SoundService")

local function playRainbowEffect(p1) --[[ playRainbowEffect | Line: 19 | Upvalues: CollectionService (copy), TweenService (copy) ]]
	local t = {}

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and CollectionService:HasTag(v, "Colorable") then
			table.insert(t, {
				part = v,
				originalColor = v.Color
			})
		end
	end

	if #t ~= 0 then
		local v1 = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

		task.spawn(function() --[[ Line: 31 | Upvalues: t (copy), TweenService (ref), v1 (copy) ]]
			for i = 1, 12 do
				local v12 = Color3.fromHSV(i / 12 % 1, 1, 1)

				for i2, v in ipairs(t) do
					TweenService:Create(v.part, v1, {
						Color = v12
					}):Play()
				end

				task.wait(0.25)
			end

			local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			for i, v in ipairs(t) do
				if v.part.Parent then
					TweenService:Create(v.part, v2, {
						Color = v.originalColor
					}):Play()
				end
			end
		end)
	end
end

local function formatCooldown(p1) --[[ formatCooldown | Line: 51 ]]
	local v2 = math.max(0, (math.floor(p1)))

	return string.format("%d:%02d", math.floor(v2 / 60), v2 % 60)
end

local function getCooldownLeft() --[[ getCooldownLeft | Line: 58 | Upvalues: WeatherMachineData (copy) ]]
	return (WeatherMachineData:GetAttribute("CooldownUntil") or 0) - os.time()
end

local function updateDisplay(p1, p2) --[[ updateDisplay | Line: 63 | Upvalues: WeatherMachineData (copy) ]]
	local TextLabel = p1:FindFirstChild("TextLabel")

	if not TextLabel then
		return
	end

	local SurfaceGui = TextLabel:FindFirstChild("SurfaceGui")

	if not SurfaceGui then
		return
	end

	local TextLabel2 = SurfaceGui:FindFirstChild("TextLabel")

	if not TextLabel2 then
		return
	end

	local v1 = (WeatherMachineData:GetAttribute("CooldownUntil") or 0) - os.time()
	local Frame = SurfaceGui:FindFirstChild("Frame")
	local v2 = if Frame then Frame:FindFirstChild("Frame") else Frame

	if v1 > 0 then
		local v4 = math.max(0, (math.floor(v1)))

		TextLabel2.Text = string.format("%d:%02d", math.floor(v4 / 60), v4 % 60)
		TextLabel2.TextColor3 = Color3.new(255/255, 0/255, 0/255)

		if v2 then
			v2.Size = UDim2.new(0, 0, 1, 0)
		end

		v2.Parent.Visible = false
	else
		local v7 = math.clamp(p2, 0, 100)

		TextLabel2.Text = string.format("%.1f", v7) .. "%"
		TextLabel2.TextColor3 = Color3.new(255/255, 255/255, 255/255)

		if v2 then
			v2.Size = UDim2.new(v7 / 100, 0, 1, 0)
		end

		v2.Parent.Visible = true
	end
end

local t = {}

local function getOrCreateSFX(p1) --[[ getOrCreateSFX | Line: 95 | Upvalues: SoundService (copy) ]]
	local v1 = p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart")

	if not v1 then
		return nil
	end

	local WeatherMachineSFX = v1:FindFirstChild("WeatherMachineSFX")

	if WeatherMachineSFX then
		return WeatherMachineSFX
	end

	local WeatherMachineSFX2 = Instance.new("Sound")

	WeatherMachineSFX2.Name = "WeatherMachineSFX"
	WeatherMachineSFX2.SoundId = "rbxassetid://134599864373665"
	WeatherMachineSFX2.Volume = 0
	WeatherMachineSFX2.RollOffMaxDistance = 200
	WeatherMachineSFX2.Looped = true
	WeatherMachineSFX2.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	WeatherMachineSFX2.Parent = v1

	return WeatherMachineSFX2
end

local function updateModel(p1, p2) --[[ updateModel | Line: 113 | Upvalues: getOrCreateSFX (copy), t (copy), TweenService (copy) ]]
	if not (p1 and p1.Parent) then
		return
	end

	if not p1:FindFirstChild("plr_Val") then
		return
	end

	local v1 = p2 > 0

	p1.plr_Val.Value = p2

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = v1
		end
	end

	local v2 = getOrCreateSFX(p1)

	if v2 then
		if t[p1] then
			t[p1]:Cancel()
			t[p1] = nil
		end

		if v1 then
			if not v2.Playing then
				v2:Play()
			end

			local v3 = TweenService:Create(v2, TweenInfo.new(1), {
				Volume = 1
			})

			v3:Play()
			t[p1] = v3
		else
			local v4 = TweenService:Create(v2, TweenInfo.new(1), {
				Volume = 0
			})

			v4:Play()
			t[p1] = v4
			v4.Completed:Once(function() --[[ Line: 144 | Upvalues: v2 (copy) ]]
				if not (v2.Volume <= 0.01) then
					return
				end

				v2:Stop()
			end)
		end
	end

	local Icon = p1:FindFirstChild("Icon")

	if Icon and Icon:FindFirstChild("Decal") then
		Icon.Decal.Color3 = v1 and Color3.new(0, 0.666667, 1) or Color3.new(255/255, 255/255, 255/255)
	end

	local Speed_MULTI = p1:FindFirstChild("Speed_MULTI")

	if not Speed_MULTI then
		return
	end

	local SurfaceGui = Speed_MULTI:FindFirstChild("SurfaceGui")
	local v6 = if SurfaceGui then SurfaceGui:FindFirstChild("TextLabel") else SurfaceGui

	if not v6 then
		return
	end

	local v7 = tostring(p2)

	v6.Text = v7 .. "/" .. tostring(#game.Players:GetPlayers())
end

return function(p1) --[[ Line: 169 | Upvalues: updateDisplay (copy), WeatherMachineData (copy), playRainbowEffect (copy), updateModel (copy), Zone (copy), Networking (copy) ]]
	local count = 0
	local v1

	repeat
		v1 = game:GetService("Players"):GetPlayerByUserId(p1:GetAttribute("UserId"))

		if not v1 then
			task.wait(0.5)
			count = count + 1
		end
	until v1 or count >= 20

	if not v1 then
		return
	end

	local Fill_Val = p1:FindFirstChild("Fill_Val")

	if not Fill_Val then
		return
	end

	local v2 = p1:GetAttribute("PropId")

	if not v2 then
		return
	end

	updateDisplay(p1, Fill_Val.Value)
	Fill_Val:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 191 | Upvalues: updateDisplay (ref), p1 (copy), Fill_Val (copy) ]]
		updateDisplay(p1, Fill_Val.Value)
	end)
	task.spawn(function() --[[ Line: 196 | Upvalues: p1 (copy), WeatherMachineData (ref), updateDisplay (ref), Fill_Val (copy) ]]
		while p1.Parent do
			if (WeatherMachineData:GetAttribute("CooldownUntil") or 0) - os.time() > 0 then
				updateDisplay(p1, Fill_Val.Value)
			end

			task.wait(1)
		end
	end)
	WeatherMachineData:GetAttributeChangedSignal("CooldownUntil"):Connect(function() --[[ Line: 205 | Upvalues: updateDisplay (ref), p1 (copy), Fill_Val (copy), WeatherMachineData (ref), playRainbowEffect (ref) ]]
		updateDisplay(p1, Fill_Val.Value)

		if not ((WeatherMachineData:GetAttribute("CooldownUntil") or 0) - os.time() > 0) then
			return
		end

		playRainbowEffect(p1)
	end)

	local t = {}

	local function connectToData(p12) --[[ connectToData | Line: 214 | Upvalues: t (copy), v2 (copy), Fill_Val (copy), updateModel (ref), p1 (copy) ]]
		if t[p12] then
			return
		end

		if p12.Name ~= v2 then
			return
		end

		local t2 = {}

		t[p12] = t2

		local Fill_Value = p12:FindFirstChild("Fill_Value")
		local Active_Players = p12:FindFirstChild("Active_Players")

		if Fill_Value and Active_Players then
			Fill_Val.Value = Fill_Value.Value

			local function f2() --[[ Line: 228 | Upvalues: Fill_Val (ref), Fill_Value (copy) ]]
				Fill_Val.Value = Fill_Value.Value
			end

			table.insert(t2, Fill_Value:GetPropertyChangedSignal("Value"):Connect(f2))

			local function refreshModel() --[[ refreshModel | Line: 232 | Upvalues: updateModel (ref), p1 (ref), Active_Players (copy) ]]
				updateModel(p1, #Active_Players:GetChildren())
			end

			updateModel(p1, #Active_Players:GetChildren())
			table.insert(t2, Active_Players.ChildAdded:Connect(refreshModel))
			table.insert(t2, Active_Players.ChildRemoved:Connect(refreshModel))
			table.insert(t2, game.Players.PlayerAdded:Connect(refreshModel))
		end
	end

	local function disconnectData(p1) --[[ disconnectData | Line: 242 | Upvalues: t (copy) ]]
		local v1 = t[p1]

		if not v1 then
			return
		end

		for i, v in ipairs(v1) do
			v:Disconnect()
		end

		t[p1] = nil
	end

	local v3 = v1

	for i, v in ipairs(WeatherMachineData:GetChildren()) do
		connectToData(v)
	end

	WeatherMachineData.ChildAdded:Connect(connectToData)
	WeatherMachineData.ChildRemoved:Connect(disconnectData)

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("Script") then
			v.Enabled = true
		end
	end

	local ZONE = p1:WaitForChild("ZONE", 10)

	if ZONE then
		ZONE.CanQuery = true

		local v4 = Zone.new(ZONE)
		local v5 = v3.Name

		v4.localPlayerEntered:Connect(function() --[[ Line: 273 | Upvalues: v2 (copy), v5 (copy), Networking (ref) ]]
			if v2 and v5 then
				Networking.WeatherMachine.PlayerEntered:Fire(v5, v2)
			end
		end)
		v4.localPlayerExited:Connect(function() --[[ Line: 278 | Upvalues: v2 (copy), v5 (copy), Networking (ref) ]]
			if v2 and v5 then
				Networking.WeatherMachine.PlayerExited:Fire(v5, v2)
			end
		end)
	end
end