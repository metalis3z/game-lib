-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseUpgradeTransitionLifecycle = require(ReplicatedStorage.Library.Client.BaseUpgradeTransitionLifecycle)
local Audio = require(ReplicatedStorage.Library.Audio)

return {
	Play = function(p1) --[[ Play | Line: 93 | Upvalues: Workspace (copy), BaseUpgradeTransitionLifecycle (copy), Audio (copy) ]]
		assert(if Workspace.CurrentCamera == nil then false else true, "Base upgrade transition requires CurrentCamera")
		BaseUpgradeTransitionLifecycle.Begin()
		Audio.Play(119855061490364, script, { 0.9, 1.1 }, 1.5)
		task.spawn(p1)
		BaseUpgradeTransitionLifecycle.Complete()
	end
}