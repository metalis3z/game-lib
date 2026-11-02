-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local LocalPlayer = game.Players.LocalPlayer

game:GetService("RunService")
game:GetService("TweenService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

workspace:WaitForChild("__DEBRIS")

local Orb = ReplicatedStorage.Assets.Orb
local _ = {
	Color3.fromRGB(0, 255, 255),
	Color3.fromRGB(0, 255, 218),
	Color3.fromRGB(0, 255, 182),
	Color3.fromRGB(0, 255, 145),
	Color3.fromRGB(0, 255, 109),
	Color3.fromRGB(0, 255, 73),
	Color3.fromRGB(0, 255, 36),
	Color3.fromRGB(0, 255, 0)
}

local function GetRootPart() --[[ GetRootPart | Line: 22 | Upvalues: LocalPlayer (copy) ]]
	local v1 = LocalPlayer and LocalPlayer.Character

	if not v1 then
		return nil
	end

	return v1:FindFirstChild("HumanoidRootPart") or v1:FindFirstChild("Torso")
end

local function playOrbs(p1, p2, p3, p4) --[[ playOrbs | Line: 30 ]] end

function t.Play(p1, p2, p3) --[[ Play | Line: 88 | Upvalues: playOrbs (copy) ]]
	return playOrbs(p1, p2, p3)
end
function t.PlayOnDonate(p1, p2, p3, p4) --[[ PlayOnDonate | Line: 92 | Upvalues: playOrbs (copy) ]]
	return playOrbs(p1, p2, p3, p4)
end

return t