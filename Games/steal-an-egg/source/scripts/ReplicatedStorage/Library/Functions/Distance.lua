-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Library = ReplicatedStorage:WaitForChild("Library")
local Player = require(Library.Player)

return function(p1, p2) --[[ Line: 6 | Upvalues: Player (copy), Players (copy) ]]
	local v1

	if p1 and (typeof(p1) ~= "Instance" or not p1:IsA("Player")) then
		v1 = if typeof(p1) == "CFrame" or (typeof(p1) == "BasePart" or (typeof(p1) == "MeshPart" or typeof(p1) == "Part")) then p1.Position elseif typeof(p1) == "Instance" and p1.ClassName == "Model" then p1:GetPivot().Position else p1
	else
		local v2 = if p1 then Player.Optional.Humanoid(p1) else Player.Optional.Humanoid(Players.LocalPlayer)

		if not v2 then
			return nil
		end

		local RootPart = v2.RootPart

		if not RootPart then
			return nil
		end

		v1 = RootPart.Position
	end

	if not v1 then
		return nil
	end

	if typeof(p2) == "Instance" and p2:IsA("Player") then
		local v5 = Player.Optional.Humanoid(p2)

		if not v5 then
			return nil
		end

		local RootPart = v5.RootPart

		if not RootPart then
			return nil
		end

		p2 = RootPart.Position
	elseif typeof(p2) == "CFrame" or (typeof(p2) == "BasePart" or (typeof(p2) == "MeshPart" or typeof(p2) == "Part")) then
		p2 = p2.Position
	elseif typeof(p2) == "Instance" and p2.ClassName == "Model" then
		p2 = p2:GetPivot().Position
	end

	if p2 and (typeof(v1) == "Vector3" and typeof(p2) == "Vector3") then
		return (v1 - p2).Magnitude
	end

	return nil
end