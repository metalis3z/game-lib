-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = require(ReplicatedStorage.Library.Player)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local TrappedBackpackLock = require(script.Parent.Parent.Parent.GUI.TrappedBackpackLock)
local LocalPlayer = Players.LocalPlayer
local v1 = Trove.new()
local v2 = false

local function unequipLocalTools() --[[ unequipLocalTools | Line: 24 | Upvalues: Player (copy), LocalPlayer (copy) ]]
	local v1 = Player.Optional.Humanoid(LocalPlayer)

	if not v1 then
		return
	end

	v1:UnequipTools()
end

local function setTrapBackpackLocked(p1) --[[ setTrapBackpackLocked | Line: 31 | Upvalues: v2 (ref), Player (copy), LocalPlayer (copy), TrappedBackpackLock (copy) ]]
	if v2 == p1 then
		if not p1 then
			return
		end

		local v1 = Player.Optional.Humanoid(LocalPlayer)

		if not v1 then
			return
		end

		v1:UnequipTools()
	else
		v2 = p1

		if not p1 then
			TrappedBackpackLock.SetLocked(false)

			return
		end

		TrappedBackpackLock.SetLocked(true)

		local v22 = Player.Optional.Humanoid(LocalPlayer)

		if not v22 then
			return
		end

		v22:UnequipTools()
	end
end

local function refreshCharacterTrapState(p1) --[[ refreshCharacterTrapState | Line: 50 | Upvalues: v2 (ref), Player (copy), LocalPlayer (copy), TrappedBackpackLock (copy) ]]
	local v1 = p1:GetAttribute("IsTrapped") == true

	if v2 == v1 then
		if not v1 then
			return
		end

		local v22 = Player.Optional.Humanoid(LocalPlayer)

		if v22 then
			v22:UnequipTools()
		end
	else
		v2 = v1

		if v1 then
			TrappedBackpackLock.SetLocked(true)

			local v3 = Player.Optional.Humanoid(LocalPlayer)

			if v3 then
				v3:UnequipTools()
			end
		else
			TrappedBackpackLock.SetLocked(false)
		end
	end
end

local function bindCharacter(p1) --[[ bindCharacter | Line: 54 | Upvalues: v1 (copy), v2 (ref), TrappedBackpackLock (copy), Player (copy), LocalPlayer (copy) ]]
	v1:Clean()
	v1:Add(function() --[[ Line: 57 | Upvalues: v2 (ref), TrappedBackpackLock (ref) ]]
		if v2 ~= false then
			v2 = false
			TrappedBackpackLock.SetLocked(false)
		end
	end)
	v1:Connect(p1:GetAttributeChangedSignal("IsTrapped"), function() --[[ Line: 61 | Upvalues: p1 (copy), v2 (ref), Player (ref), LocalPlayer (ref), TrappedBackpackLock (ref) ]]
		local v1 = p1:GetAttribute("IsTrapped") == true

		if v2 == v1 then
			if not v1 then
				return
			end

			local v22 = Player.Optional.Humanoid(LocalPlayer)

			if v22 then
				v22:UnequipTools()
			end
		else
			v2 = v1

			if v1 then
				TrappedBackpackLock.SetLocked(true)

				local v3 = Player.Optional.Humanoid(LocalPlayer)

				if v3 then
					v3:UnequipTools()
				end
			else
				TrappedBackpackLock.SetLocked(false)
			end
		end
	end)
	v1:Connect(p1.ChildAdded, function(p1) --[[ Line: 65 | Upvalues: v2 (ref), Player (ref), LocalPlayer (ref) ]]
		if not (v2 and p1:IsA("Tool")) then
			return
		end

		local v1 = Player.Optional.Humanoid(LocalPlayer)

		if not v1 then
			return
		end

		v1:UnequipTools()
	end)

	local v12 = p1:GetAttribute("IsTrapped") == true

	if v2 == v12 then
		if not v12 then
			return
		end

		local v22 = Player.Optional.Humanoid(LocalPlayer)

		if v22 then
			v22:UnequipTools()
		end
	else
		v2 = v12

		if v12 then
			TrappedBackpackLock.SetLocked(true)

			local v3 = Player.Optional.Humanoid(LocalPlayer)

			if v3 then
				v3:UnequipTools()
			end
		else
			TrappedBackpackLock.SetLocked(false)
		end
	end
end

LocalPlayer.CharacterAdded:Connect(bindCharacter)

local v3 = Player.Optional.Character(LocalPlayer)

if not v3 then
	return
end

bindCharacter(v3)