-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Library.Audio)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local v1 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = Log.new()
local ImageLabel = GUI.Damage().ImageLabel
local v3 = nil

return {
	Preload = function() --[[ Preload | Line: 30 | Upvalues: ImageLabel (copy), ContentProvider (copy), v2 (copy) ]]
		ImageLabel.ImageTransparency = 1
		task.spawn(function() --[[ Line: 32 | Upvalues: ContentProvider (ref), ImageLabel (ref) ]]
			ContentProvider:PreloadAsync({ ImageLabel })
		end)
		v2:AtDebug():Log("Damage feedback image preload requested")
	end,
	Play = function() --[[ Play | Line: 38 | Upvalues: v3 (ref), ImageLabel (copy), Audio (copy), TweenService (copy), v1 (copy) ]]
		local v12 = v3
		local v2

		if v12 then
			v12:Cancel()
		end

		ImageLabel.ImageTransparency = 0
		Audio.Play(139459336979009, script, 1, 0.5)
		v2 = TweenService:Create(ImageLabel, v1, {
			ImageTransparency = 1
		})
		v3 = v2
		v2:Play()
	end
}