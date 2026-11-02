local t = {}
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

function t.JumpscareShadowWithEyesIMG() --[[ JumpscareShadowWithEyesIMG | Line: 4 | Upvalues: Lib (copy) ]]
	local v1 = Lib.UI.Get("Jumpscare")
	local staticframe = Lib.UI.Get("static"):WaitForChild("staticframe")
	local ImageTransparency = staticframe.ImageTransparency
	local image = v1.image

	image.Visible = true
	image.ImageTransparency = 0.999
	task.wait(0.1)
	image.ImageTransparency = 0
	v1.Vignette.ImageTransparency = 0
	staticframe.ImageTransparency = 0.8
	Lib.MusicService.Get("Asylum Night Shift Sounds - Suspense", "jumpscare"):Play()
	Lib.MusicService.Get("mini-pekka-sound-hit", "jumpscare"):Play()

	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local Position = image.Position
	local v2 = tick()

	task.delay(1, function() --[[ Line: 30 | Upvalues: TweenService (copy), image (copy), v1 (copy), staticframe (copy), ImageTransparency (copy) ]]
		TweenService:Create(image, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
			ImageTransparency = 1
		}):Play()
		TweenService:Create(v1.Vignette, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
			ImageTransparency = 1
		}):Play()
		TweenService:Create(staticframe, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
			ImageTransparency = ImageTransparency
		}):Play()
	end)

	local v3 = nil

	v3 = RunService.Heartbeat:Connect(function() --[[ Line: 38 | Upvalues: v2 (copy), v3 (ref), image (copy), Position (copy), v1 (copy) ]]
		local v12 = tick() - v2

		if v12 >= 1.5 then
			v3:Disconnect()
			image.Position = Position
			v1.Enabled = false
		else
			local v22 = 8 * (1 - v12 / 1.5)
			local v32 = (math.random() * 2 - 1) * v22

			image.Position = UDim2.new(Position.X.Scale, Position.X.Offset + v32, Position.Y.Scale, Position.Y.Offset + (math.random() * 2 - 1) * v22)
		end
	end)
end
function t.JumpscareHollow(p1) --[[ JumpscareHollow | Line: 57 | Upvalues: Lib (copy) ]]
	Lib.MusicService.Get("horror jumpscare", "jumpscare").sound:Play()

	local v1 = p1:FindFirstChild("NeckBone") and p1.NeckBone.Value

	if not v1 then
		return
	end

	v1:SetAttribute("HeadRotationFull", true)
	p1:AddTag("HeadRotationEnabled")
end
Lib.Network:BindEvents({
	JumpscareShadowWithEyesIMG = t.JumpscareShadowWithEyesIMG,
	JumpscareHollow = t.JumpscareHollow
})
function t.JumpscareShadow(p1) --[[ JumpscareShadow | Line: 73 | Upvalues: Lib (copy) ]]
	game.ReplicatedStorage:WaitForChild("NPCs"):WaitForChild("Anomalies")

	local v1 = Lib.CS:GetTagged("Shadow")[1]
	local v2 = v1.Parent

	v1.Parent = workspace.Misc

	local CurrentCamera = workspace.CurrentCamera
	local v3 = Random.new()

	v1:SetPrimaryPartCFrame(CFrame.new(CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * 3, CurrentCamera.CFrame.Position))
	Lib.MusicService.Get("rake-jumpscare-sound-effect (loud)", "jumpscare").sound:Play()

	local sound = Lib.MusicService.Get("horror jumpscare", "jumpscare").sound

	task.delay(sound.TimeLength - 1, function() --[[ Line: 88 | Upvalues: sound (copy), Lib (ref) ]]
		Lib.TS:Create(sound, TweenInfo.new(1), {
			Volume = 0
		}):Play()
		task.wait(1)
		sound.Volume = sound.Volume
	end)
	sound:Play()

	local v5 = CurrentCamera.CFrame
	local v6 = tick()

	while true and tick() - v6 < 1.5 do
		CurrentCamera.CFrame = v5 * CFrame.new(v3:NextNumber(-0.5, 0.5), v3:NextNumber(-0.5, 0.5), v3:NextNumber(-0.5, 0.5))
		task.wait()
	end

	CurrentCamera.CFrame = v5
	v1.Parent = v2
end
function t.JumpscareStalker(p1) --[[ JumpscareStalker | Line: 120 | Upvalues: Lib (copy) ]]
	local v1 = Lib.CS:GetTagged("TallMonsterHead")[1]
	local v2 = v1.Parent

	v1.Parent = workspace.Misc

	local CurrentCamera = workspace.CurrentCamera
	local v3 = Random.new()

	Lib.MusicService.Get("rake-jumpscare-sound-effect (loud)", "jumpscare").sound:Play()

	local sound = Lib.MusicService.Get("horror jumpscare", "jumpscare").sound

	task.delay(sound.TimeLength - 1, function() --[[ Line: 134 | Upvalues: sound (copy), Lib (ref) ]]
		Lib.TS:Create(sound, TweenInfo.new(1), {
			Volume = 0
		}):Play()
		task.wait(1)
		sound.Volume = sound.Volume
	end)
	sound:Play()

	local v4 = CurrentCamera.CFrame
	local v5 = tick()

	while true and tick() - v5 < 0.5 do
		CurrentCamera.CFrame = v4 * CFrame.new(v3:NextNumber(-0.5, 0.5), v3:NextNumber(-0.5, 0.5), v3:NextNumber(-0.5, 0.5))
		task.wait()
	end

	CurrentCamera.CFrame = v4
	v1.Parent = v2
end

return t