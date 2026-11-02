local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local TallMonster = game.ReplicatedStorage:WaitForChild("NPCs"):WaitForChild("Anomalies"):WaitForChild("TallMonster")

Random.new()

local LocalPlayer = game.Players.LocalPlayer
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = false

local function stopPeekAnim() --[[ stopPeekAnim | Line: 11 | Upvalues: v1 (ref) ]]
	if not (v1 and v1.IsPlaying) then
		return
	end

	v1:Stop()
end

Lib.CS:GetInstanceAddedSignal("TallMonsterSpawn"):Connect(function(p1) --[[ Line: 17 | Upvalues: TallMonster (copy), LocalPlayer (copy), v4 (ref), v2 (ref), v1 (ref) ]]
	TallMonster:SetPrimaryPartCFrame(p1.CFrame)

	local v12 = false
	local v22 = false

	while p1:HasTag("TallMonsterSpawn") and p1:GetAttribute("TallMonsterSpawn") do
		local Character = LocalPlayer.Character

		if Character and Character.PrimaryPart then
			local v3 = p1.CFrame.LookVector:Dot((workspace.CurrentCamera.CFrame.Position - p1.Position).Unit)

			if v3 > 0.2 then
				v12 = true
			elseif v3 < -0.2 then
				v12 = false
			end

			local v5 = if v12 then not (p1:GetAttribute("NoSecurity") and Character:GetAttribute("Zone") == "Security") else v12

			if v5 and TallMonster.Parent ~= workspace.NPCs then
				v4 = true
				TallMonster.Parent = workspace.NPCs
				TallMonster:AddTag("HeadRotationEnabled")
				v2:Play()

				if p1:GetAttribute("Corner") and not v22 then
					v1:AdjustSpeed(1)
					v1:Play(0, 1, 1)
					task.wait(v1.Length * 0.9)
					v1:AdjustSpeed(0)
					v1.TimePosition = v1.Length * 0.9
					v22 = true
				end

				v4 = false
			elseif not v5 and TallMonster.Parent == workspace.NPCs then
				v2:Stop()

				if not (v1 and v1.IsPlaying) then
					TallMonster.Parent = game.ReplicatedStorage.NPCs.Anomalies

					return
				end

				v1:Stop()
				TallMonster.Parent = game.ReplicatedStorage.NPCs.Anomalies

				return
			end

			task.wait(0.5)
		else
			task.wait(0.1)
		end
	end
end)
Lib.CS:GetInstanceRemovedSignal("TallMonsterSpawn"):Connect(function(p1) --[[ Line: 65 | Upvalues: TallMonster (copy) ]]
	TallMonster.Parent = game.ReplicatedStorage.NPCs.Anomalies
end)

local function Jumpscare(p1) --[[ Jumpscare | Line: 69 | Upvalues: Lib (copy), v1 (ref), TallMonster (copy) ]]
	print("playing tall jumpscare")
	p1:SetAttribute("TallMonsterSpawn", false)

	local v12 = Lib.Find.ClosestLight(p1.Position)

	if v12 then
		v12.SpotLight.Enabled = false
		v12:SetAttribute("OriginalColor", v12:GetAttribute("OriginalColor") or v12.SpotLight.Color)
		v12.Color = Color3.new(0/255, 0/255, 0/255)
		task.spawn(Lib.PlaySoundAt, "Light Switch Off", v12.Position, "sfx")
		task.spawn(Lib.PlaySoundAt, "Scare.wav", v12.Position, "jumpscare")
	end

	v1:AdjustSpeed(-1.5)
	v1.TimePosition = v1.Length * 0.98
	task.wait(v1.TimePosition * 0.925 / 1.5)
	TallMonster.Parent = game.ReplicatedStorage.NPCs.Anomalies

	if v1 and v1.IsPlaying then
		v1:Stop()
	end

	local v4 = Lib.GetCurrentInspect()

	if v4 and (v4:HasTag("StalkerPhoto") and v4.PrimaryPart) then
		Lib.PoofLocation(v4.PrimaryPart.Position, "Sizzle")
		v4:Destroy()
		Lib.PlayerLostSanity(-1, "What...?")
		Lib.Notify("The photo burns in your hands...")
	else
		Lib.PlayerLostSanity(10, "Stalker")
	end

	task.wait(3)

	if not v12 then
		return
	end

	v12.SpotLight.Enabled = true
	task.spawn(Lib.PlaySoundAt, "Light Switch Off", v12.Position, "sfx")
	v12.Color = v12:GetAttribute("OriginalColor") or Color3.new(255/255, 255/255, 255/255)
end

local function SetUp() --[[ SetUp | Line: 112 | Upvalues: TallMonster (copy), v2 (ref), v1 (ref), v3 (ref), Lib (copy), v4 (ref), Jumpscare (copy) ]]
	local Animator = TallMonster:WaitForChild("AnimationController"):WaitForChild("Animator")

	v2 = game.ReplicatedStorage:WaitForChild("Animations"):WaitForChild("TallMonsterIdle")
	v2 = Animator:LoadAnimation(v2)
	v1 = Animator:LoadAnimation(game.ReplicatedStorage:WaitForChild("Animations"):WaitForChild("TallMonsterPeek"))
	v1.Looped = false
	v3 = TallMonster.PrimaryPart:FindFirstChild("spine.006", true)

	local v12 = false

	while true do
		local v22 = Lib.CS:GetTagged("TallMonsterSpawn")[1]

		if v22 then
			if TallMonster.Parent == workspace.NPCs then
				local WorldPosition = v3.WorldPosition
				local CurrentCamera = workspace.CurrentCamera
				local _, v32 = CurrentCamera:WorldToScreenPoint(WorldPosition)

				if v32 then
					local v42 = Lib.CS:GetTagged("NPC")

					v42[#v42 + 1] = TallMonster

					for i, v in ipairs(game.Players:GetPlayers()) do
						v42[#v42 + 1] = v.Character
					end

					if #CurrentCamera:GetPartsObscuringTarget({ WorldPosition }, v42) == 0 then
						if not v12 or v4 then
							task.wait(0.15)
							v12 = true

							continue
						end

						Jumpscare(v22)
					end
				end
			end

			task.wait(0.5)
		else
			task.wait(1)
		end

		v12 = false
	end
end

task.spawn(SetUp)

return {}