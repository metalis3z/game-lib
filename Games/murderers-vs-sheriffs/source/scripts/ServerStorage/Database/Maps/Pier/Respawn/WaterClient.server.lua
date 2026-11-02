-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local LocalPlayer = game.Players.LocalPlayer
local v1 = script.Parent
local v2 = false

local function onPlayerSplash(p1) --[[ onPlayerSplash | Line: 6 ]]
	if not p1.Character then
		return
	end

	if p1.Character:FindFirstChild("HumanoidRootPart") then
		local v1 = script:WaitForChild("Splash"):Clone()

		v1.Parent = p1.Character.HumanoidRootPart
		v1:Play()
	end
end

local function onWaterPartTouched(p1) --[[ onWaterPartTouched | Line: 19 | Upvalues: LocalPlayer (copy), v2 (ref), onPlayerSplash (copy) ]]
	if p1.Name ~= "HumanoidRootPart" then
		return
	end

	local v1 = p1.Parent

	if game:GetService("Players"):GetPlayerFromCharacter(v1) ~= LocalPlayer then
		return
	end

	if v2 then
		return
	end

	v2 = true

	local Humanoid = v1:FindFirstChild("Humanoid")

	if Humanoid.Health > 0 then
		Humanoid.WalkSpeed = 0
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
		Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
		LocalPlayer.CharacterAdded:Once(function() --[[ Line: 54 | Upvalues: v2 (ref) ]]
			v2 = false
		end)
	end

	onPlayerSplash(LocalPlayer)
	script:WaitForChild("HitWater"):FireServer()
end

script:WaitForChild("HitWater").OnClientEvent:Connect(function(p1) --[[ Line: 63 | Upvalues: LocalPlayer (copy), onPlayerSplash (copy) ]]
	if p1 ~= LocalPlayer then
		onPlayerSplash(p1)
	end
end)
v1.Touched:Connect(onWaterPartTouched)