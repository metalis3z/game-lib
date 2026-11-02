-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = script.Parent
local GetMouseToWorld = require(ReplicatedStorage.Library.Functions.GetMouseToWorld)
local Manhattan2D = require(ReplicatedStorage.Library.Functions.Manhattan2D)
local PetsService = require(ReplicatedStorage.Library.Modules.PetServices.PetsService)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)

v1.Activated:Connect(function() --[[ Line: 8 | Upvalues: GetMouseToWorld (copy), Manhattan2D (copy), PetsService (copy), v1 (copy), Message (copy) ]]
	local v12 = GetMouseToWorld(RaycastParams.new(), 100)

	if not v12 then
		return
	end

	local v2 = CFrame.new(v12.Position.X, 0, v12.Position.Z)

	if Manhattan2D(v2.Position, workspace.PetArea) then
		PetsService:EquipPet(v1:GetAttribute("PET_UUID"), v2)

		return
	end

	Message.Bottom({
		Message = "You cannot place your pet here!",
		Time = 0.5
	})
end)