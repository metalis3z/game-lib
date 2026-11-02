-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local HideImportantUI = require(ReplicatedStorage.Library.Client.HideImportantUI)
local Main = require(script.Parent.BackpackController.Main)
local v1 = GUI.Backpack()
local v2 = false
local v3 = nil

return {
	SetLocked = function(p1) --[[ SetLocked | Line: 32 | Upvalues: v2 (ref), v3 (ref), Main (copy), v1 (copy), HideImportantUI (copy) ]]
		if v2 == p1 then
			return
		end

		v2 = p1

		if p1 then
			v3 = Main:GetBackpackEnabled()
			Main:SetBackpackEnabled(false)
			v1.Enabled = false

			return
		end

		local v12 = v3

		v3 = nil

		if v12 == nil then
			return
		end

		Main:SetBackpackEnabled(v12)

		if not (v12 and HideImportantUI:IsUnLocked()) then
			return
		end

		v1.Enabled = true
	end
}