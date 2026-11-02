-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local ToolCooldownUtil = require(ReplicatedStorage.Library.Util.ToolCooldownUtil)
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer

return {
	Initialize = function(p1, p2) --[[ Initialize | Line: 33 | Upvalues: Trove (copy), Asserts (copy), ToolCooldownUtil (copy), ToolGameplayGuard (copy), LocalPlayer (copy) ]]
		local v1 = nil
		local v2 = nil
		local v3 = Trove.new()
		local v4 = type(p1) == "string" and { p1 } or p1

		Asserts.array.string(v4)

		local v6 = p2 or {}

		local function onEquipped(p1) --[[ onEquipped | Line: 43 | Upvalues: v1 (ref), Trove (ref), v2 (ref), ToolCooldownUtil (ref), v6 (ref), ToolGameplayGuard (ref), LocalPlayer (ref) ]]
			if v1 then
				v1:Clean()
			end

			v1 = Trove.new()
			v2 = p1
			ToolCooldownUtil.InitializeTool(p1)

			if v6 and v6.onEquipped then
				v6.onEquipped(p1)
			end

			if not v1 then
				return
			end

			if v6 and v6.onActivated then
				v1:Add(p1.Activated:Connect(function() --[[ Line: 62 | Upvalues: v6 (ref), ToolGameplayGuard (ref), p1 (copy) ]]
					if not (v6 and v6.onActivated) then
						return
					end

					if not ToolGameplayGuard.CanActivateLocal(p1) then
						return
					end

					v6.onActivated(p1)
				end))
			end

			v1:Add(LocalPlayer.CharacterRemoving:Connect(function() --[[ Line: 72 | Upvalues: v1 (ref) ]]
				if not v1 then
					return
				end

				v1:Clean()
			end))
		end

		local function onUnequipped() --[[ onUnequipped | Line: 79 | Upvalues: v1 (ref), v6 (ref), v2 (ref) ]]
			if v1 then
				v1:Clean()
				v1 = nil
			end

			if not (v6 and v6.onUnequipped) then
				v2 = nil

				return
			end

			v6.onUnequipped()
			v2 = nil
		end

		local function setupToolDetection(p1) --[[ setupToolDetection | Line: 92 | Upvalues: v4 (copy), onEquipped (copy), v1 (ref), v6 (ref), v2 (ref) ]]
			p1.ChildAdded:Connect(function(p1) --[[ Line: 93 | Upvalues: v4 (ref), onEquipped (ref) ]]
				if not (p1:IsA("Tool") and table.find(v4, (p1:GetAttribute("GearName")))) then
					return
				end

				onEquipped(p1)
			end)
			p1.ChildRemoved:Connect(function(p1) --[[ Line: 99 | Upvalues: v4 (ref), v1 (ref), v6 (ref), v2 (ref) ]]
				if not (p1:IsA("Tool") and table.find(v4, (p1:GetAttribute("GearName")))) then
					return
				end

				if v1 then
					v1:Clean()
					v1 = nil
				end

				if v6 and v6.onUnequipped then
					v6.onUnequipped()
				end

				v2 = nil
			end)

			local v12 = p1:FindFirstChildWhichIsA("Tool")

			if not (v12 and table.find(v4, (v12:GetAttribute("GearName")))) then
				return
			end

			onEquipped(v12)
		end

		if LocalPlayer.Character then
			setupToolDetection(LocalPlayer.Character)
		end

		v3:Add(LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 115 | Upvalues: setupToolDetection (copy) ]]
			setupToolDetection(p1)
		end))

		return {
			Cleanup = function() --[[ Cleanup | Line: 120 | Upvalues: v3 (copy), v1 (ref) ]]
				v3:Clean()

				if not v1 then
					return
				end

				v1:Clean()
			end,
			IsActive = function() --[[ IsActive | Line: 127 | Upvalues: v2 (ref) ]]
				return v2 ~= nil
			end,
			GetCurrentTool = function() --[[ GetCurrentTool | Line: 131 | Upvalues: v2 (ref) ]]
				return v2
			end,
			GetCurrentToolGearName = function() --[[ GetCurrentToolGearName | Line: 135 | Upvalues: v2 (ref) ]]
				if v2 then
					return v2:GetAttribute("GearName")
				end

				return nil
			end
		}
	end,
	StartCooldown = function(p1, p2) --[[ StartCooldown | Line: 146 | Upvalues: ToolCooldownUtil (copy) ]]
		local v1 = p1:GetCurrentTool()

		if not (v1 and v1.Parent) then
			return
		end

		ToolCooldownUtil.StartCooldown(v1, p2)
	end
}