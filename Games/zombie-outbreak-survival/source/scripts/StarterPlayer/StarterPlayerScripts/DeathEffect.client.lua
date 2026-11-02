-- Default Values
local default = {
	Blink = true,
	Blur = true,
	["Blur Size"] = 56,
	Brightness = -1,
	Color = Color3.new(1, 0, 0),
	Contrast = 0,
	["Death Sound Enabled"] = true,
	["Death Sound In Character"] = false,
	Saturation = 0,
	["Smooth Reset"] = true,
	["Smooth Reset Duration"] = 1,
	["Transition Duration"] = 5.25
}

-- Configuration Check
local config = script:WaitForChild("Configuration", 1)
if not config or config.ClassName ~= "Configuration" then
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://204074025"
	sound.Volume = 1
	sound.Parent = script
	config = setmetatable({}, {
		__index = function(t, k)
			if k == "Death Sound" then
				return sound
			end
			return {Value = default[k]}
		end
	})
	warn("\"Death Blur & Color Effects\"'s Configuration was not found or was corrputed. Using default configurations...")
end

-- Value checks
if type(config) ~= "table" then
	local missing = {}
	local usedDefault
	local sound
	if not config:WaitForChild("Death Sound", 0.25) then
		usedDefault = true
		missing[1] = "Death Sound"
		sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://204074025"
		sound.Volume = 1
		sound.Parent = script
	end
	for name, value in pairs(default) do
		local set = config:WaitForChild(name, 0.25)
		if not set or typeof(value):sub(1, 4):lower() ~= set.ClassName:sub(1, 4):lower() then
			usedDefault = true
			missing[#missing + 1] = name
		end
	end
	if #missing > 1 then
		warn("Multiple configurations for \"Death Blur & Color Effects\" were not found or had incorrect value types: " .. table.concat(missing, ", ") .. ". Using default configurations...")
	elseif #missing == 1 then
		warn("\"Death Blur & Color Effect\"'s \"" .. missing[1] .. "\" was not found or had an incorrect value type. Using default configuration (" .. tostring(default[missing[1]]) .. ")")
	end
	if usedDefault then
		local oldConfig = config
		config = setmetatable({}, {
			__index = function(t, k)
				return oldConfig:FindFirstChild(k) or (k == "Death Sound" and sound or {Value = default[k]})
			end
		})
	end
end

-- Variables
local blur
if config.Blur.Value then
	blur = Instance.new("BlurEffect")
	blur.Size = 0
	blur.Parent = workspace.CurrentCamera
end

local color = Instance.new("ColorCorrectionEffect")
color.Parent = workspace.CurrentCamera

local tweenService = game:GetService("TweenService")

local player = game:FindService("Players").LocalPlayer

local function setupBlur(char)
	
	-- Death Sound Setup
	local sound
	if config["Death Sound In Character"].Value then
		sound = config["Death Sound"]:Clone()
		sound.Parent = char:FindFirstChildOfClass("Humanoid").RootPart
	end
	
	-- Blur & Color Effects Setup
	local tweenInfo = TweenInfo.new(config["Transition Duration"].Value, config.Blink.Value and Enum.EasingStyle.Bounce or Enum.EasingStyle.Linear)
	local tween1
	if config.Blur.Value then
		tween1 = tweenService:Create(blur, tweenInfo, {Size = config["Blur Size"].Value})
	end
	local tween2 = tweenService:Create(color, tweenInfo, {Brightness = config.Brightness.Value, Contrast = config.Contrast.Value, Saturation = config.Saturation.Value, TintColor = config.Color.Value})
	
	-- Smooth Reset Setup
	local reset1
	local reset2
	if config["Smooth Reset"].Value then
		tweenInfo = TweenInfo.new(config["Smooth Reset Duration"].Value, config.Blink.Value and Enum.EasingStyle.Bounce or Enum.EasingStyle.Linear, Enum.EasingDirection.In)
		if tween1 then
			reset1 = tweenService:Create(blur, tweenInfo, {Size = 0})
		end
		reset2 = tweenService:Create(color, tweenInfo, {Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.new(1, 1, 1)})
	end
	
	-- Death Connection
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then
		repeat
			hum = char.ChildAdded:Wait()
		until hum.ClassName == "Humanoid"
	end
	hum.Died:Connect(function()
		
		-- Death Sound Play
		if config["Death Sound Enabled"].Value then
			if config["Death Sound In Character"].Value then
				sound:Play()
			else
				config["Death Sound"]:Play()
			end
		end
		
		-- Blur & Color Effects Play
		if tween1 then
			tween1:Play()
		end
		tween2:Play()
		
		-- Reset Preparation
		tween2.Completed:Wait()
		
		-- "Smooth Reset"
		if config["Smooth Reset"].Value then
			if reset1 then
				reset1:Play()
			end
			reset2:Play()
			
			-- Instant Reset
		else
			if blur then
				blur.Size = 0
			end
			color.TintColor = Color3.new(1, 1, 1)
			color.Brightness = 0
			color.Contrast = 0
			color.Saturation = 0
		end
	end)
end

-- Setup
player.CharacterAdded:Connect(setupBlur)
if player.Character then
	setupBlur(player.Character)
end
