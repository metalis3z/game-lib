--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Info = workspace:WaitForChild("Info")
local SpringFeverArt = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Zones"):WaitForChild("SpringFeverArt"))
local v1 = false
local v2 = nil
local v3 = nil

local function updateSpeedBlur() --[[ updateSpeedBlur | Line: 22 | Upvalues: LocalPlayer (copy), v3 (ref), SpringFeverArt (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	local Position = HumanoidRootPart.Position

	if v3 then
		local v1 = (Position - v3).Magnitude / 0.033

		v3 = Position
		SpringFeverArt.UpdateSpeedBlur(v1, Character, HumanoidRootPart)
	else
		v3 = Position
	end
end

local function updateVisuals() --[[ updateVisuals | Line: 42 | Upvalues: LocalPlayer (copy), v3 (ref), SpringFeverArt (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	local Position = HumanoidRootPart.Position

	if v3 then
		local v1 = (Position - v3).Magnitude / 0.033

		v3 = Position
		SpringFeverArt.UpdateSpeedBlur(v1, Character, HumanoidRootPart)
	else
		v3 = Position
	end
end

local function activate() --[[ activate | Line: 53 | Upvalues: v1 (ref), LocalPlayer (copy), SpringFeverArt (copy), v3 (ref), v2 (ref), RunService (copy), updateVisuals (copy) ]]
	if v1 then
		return
	end

	v1 = true

	local Character = LocalPlayer.Character

	if Character then
		SpringFeverArt.Activate(Character)
	end

	v3 = nil
	v2 = RunService.RenderStepped:Connect(updateVisuals)
end

local function deactivate() --[[ deactivate | Line: 70 | Upvalues: v1 (ref), SpringFeverArt (copy), v2 (ref) ]]
	if not v1 then
		return
	end

	v1 = false
	SpringFeverArt.Deactivate()

	if not v2 then
		return
	end

	v2:Disconnect()
	v2 = nil
end

local function checkState() --[[ checkState | Line: 85 | Upvalues: Info (copy), v1 (ref), LocalPlayer (copy), SpringFeverArt (copy), v3 (ref), v2 (ref), RunService (copy), updateVisuals (copy) ]]
	if Info:GetAttribute("SpringFeverActive") then
		if v1 then
			return
		end

		v1 = true

		local Character = LocalPlayer.Character

		if Character then
			SpringFeverArt.Activate(Character)
		end

		v3 = nil
		v2 = RunService.RenderStepped:Connect(updateVisuals)
	else
		if not v1 then
			return
		end

		v1 = false
		SpringFeverArt.Deactivate()

		if not v2 then
			return
		end

		v2:Disconnect()
		v2 = nil
	end
end

Info:GetAttributeChangedSignal("SpringFeverActive"):Connect(checkState)

if Info:GetAttribute("SpringFeverActive") then
	if not v1 then
		v1 = true

		local Character = LocalPlayer.Character

		if Character then
			SpringFeverArt.Activate(Character)
		end

		v3 = nil
		v2 = RunService.RenderStepped:Connect(updateVisuals)
	end
elseif v1 then
	v1 = false
	SpringFeverArt.Deactivate()

	if v2 then
		v2:Disconnect()
		v2 = nil
	end
end

LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 97 | Upvalues: v1 (ref), SpringFeverArt (copy) ]]
	if not v1 then
		return
	end

	task.wait(1)

	if v1 then
		SpringFeverArt.OnRespawn(p1)
	end
end)