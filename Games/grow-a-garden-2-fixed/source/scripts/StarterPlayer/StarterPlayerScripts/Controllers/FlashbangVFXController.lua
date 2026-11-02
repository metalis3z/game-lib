--credit to quartz games studio
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local CurrentCamera = workspace.CurrentCamera
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local t = {
	Init = function(p1) --[[ Init | Line: 19 ]] end
}

function t.Start(p1) --[[ Start | Line: 21 | Upvalues: Networking (copy), t (copy) ]]
	Networking.Flashbang.Flashbang.OnClientEvent:Connect(function() --[[ Line: 22 | Upvalues: t (ref) ]]
		t:Flash(1, 1.75)
	end)
	Networking.Flashbang.Detonate.OnClientEvent:Connect(function() --[[ Line: 26 | Upvalues: t (ref) ]]
		t:DetonationFlash()
	end)
end

local function getOrCreateWhiteFrame() --[[ getOrCreateWhiteFrame | Line: 31 | Upvalues: Players (copy) ]]
	local v1 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui")

	if not v1 then
		return nil
	end

	local FlashbangGui = v1:FindFirstChild("FlashbangGui")

	if not FlashbangGui then
		local FlashbangGui2 = Instance.new("ScreenGui")

		FlashbangGui2.Name = "FlashbangGui"
		FlashbangGui2.DisplayOrder = 999
		FlashbangGui2.IgnoreGuiInset = true
		FlashbangGui2.ResetOnSpawn = false
		FlashbangGui2.Parent = v1
		FlashbangGui = FlashbangGui2
	end

	local WhiteFrame = FlashbangGui:FindFirstChild("WhiteFrame")

	if not WhiteFrame then
		local WhiteFrame2 = Instance.new("Frame")

		WhiteFrame2.Name = "WhiteFrame"
		WhiteFrame2.Size = UDim2.fromScale(1, 1)
		WhiteFrame2.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
		WhiteFrame2.BackgroundTransparency = 1
		WhiteFrame2.BorderSizePixel = 0
		WhiteFrame2.Parent = FlashbangGui
		WhiteFrame = WhiteFrame2
	end

	return WhiteFrame
end

function t.Flash(p1, p2, p3) --[[ Flash | Line: 61 | Upvalues: getOrCreateWhiteFrame (copy), TweenService (copy), Debris (copy), Lighting (copy), CurrentCamera (copy) ]]
	local v1 = p3 or 0.5

	task.spawn(function() --[[ Line: 63 | Upvalues: p2 (copy), getOrCreateWhiteFrame (ref), TweenService (ref), Debris (ref), Lighting (ref), CurrentCamera (ref), v1 (ref) ]]
		local v12 = TweenInfo.new(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v2 = TweenInfo.new(p2 * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v3 = getOrCreateWhiteFrame()

		v3.Parent.Enabled = true

		if v3 then
			v3.BackgroundTransparency = 1

			local v4 = TweenService:Create(v3, v12, {
				BackgroundTransparency = 0
			})

			v4:Play()
			Debris:AddItem(v4, v12.Time)
		end

		local v5 = TweenService:Create(Lighting, v12, {
			ExposureCompensation = 9
		})

		v5:Play()
		Debris:AddItem(v5, v12.Time)

		local v6 = TweenService:Create(CurrentCamera, v12, {
			FieldOfView = 80
		})

		v6:Play()
		Debris:AddItem(v6, v12.Time)
		task.wait(p2 + v1)

		local v7 = TweenService:Create(Lighting, v2, {
			ExposureCompensation = 0
		})

		v7:Play()
		Debris:AddItem(v7, v2.Time)

		local v8 = TweenService:Create(CurrentCamera, v2, {
			FieldOfView = 70
		})

		v8:Play()
		Debris:AddItem(v8, v2.Time)

		if not v3 then
			return
		end

		local v9 = TweenService:Create(v3, v2, {
			BackgroundTransparency = 1
		})

		v9:Play()
		Debris:AddItem(v9, v2.Time)
	end)
end
function t.DetonationFlash(p1) --[[ DetonationFlash | Line: 100 | Upvalues: getOrCreateWhiteFrame (copy), TweenService (copy), Debris (copy), Lighting (copy), CurrentCamera (copy), SoundService (copy) ]]
	task.spawn(function() --[[ Line: 101 | Upvalues: getOrCreateWhiteFrame (ref), TweenService (ref), Debris (ref), Lighting (ref), CurrentCamera (ref), SoundService (ref) ]]
		local v1 = getOrCreateWhiteFrame()

		if v1 then
			local v2 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local v3 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			v1.Parent.Enabled = true
			v1.BackgroundTransparency = 1

			local v4 = TweenService:Create(v1, v2, {
				BackgroundTransparency = 0
			})

			v4:Play()
			Debris:AddItem(v4, v2.Time)

			local v5 = TweenService:Create(Lighting, v2, {
				ExposureCompensation = 9
			})

			v5:Play()
			Debris:AddItem(v5, v2.Time)

			local v6 = TweenService:Create(CurrentCamera, v2, {
				FieldOfView = 80
			})

			v6:Play()
			Debris:AddItem(v6, v2.Time)

			local Sound = Instance.new("Sound")

			Sound.SoundId = "rbxassetid://122137666092419"
			Sound.Volume = 2
			Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
			Sound.Parent = v1.Parent
			Sound:Play()
			Debris:AddItem(Sound, 30)
			task.spawn(function() --[[ Line: 130 | Upvalues: Sound (copy), TweenService (ref), Debris (ref) ]]
				if not Sound.IsLoaded then
					Sound.Loaded:Wait()
				end

				local TimeLength = Sound.TimeLength

				if not (TimeLength > 0 and Sound.Parent) then
					return
				end

				local v1 = TweenInfo.new(TimeLength, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
				local v2 = TweenService:Create(Sound, v1, {
					Volume = 0.5
				})

				v2:Play()
				Debris:AddItem(v2, v1.Time)
			end)
			task.wait(math.random(40, 50) * 0.1)

			local v8 = TweenService:Create(v1, v3, {
				BackgroundTransparency = 1
			})

			v8:Play()
			Debris:AddItem(v8, v3.Time)

			local v9 = TweenService:Create(Lighting, v3, {
				ExposureCompensation = 0
			})

			v9:Play()
			Debris:AddItem(v9, v3.Time)

			local v10 = TweenService:Create(CurrentCamera, v3, {
				FieldOfView = 70
			})

			v10:Play()
			Debris:AddItem(v10, v3.Time)
		end
	end)
end

return t