-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local TreadmillVideoController = require(ReplicatedStorage.Library.Client.TreadmillVideoController)

require(ReplicatedStorage.Library.Client.TreadmillVideoController.Types.Interface)

local v1 = GUI.StaticTreadmillImageSurfaceGui()

assert(v1:IsA("SurfaceGui"), "Static treadmill image GUI must be a SurfaceGui")

local t = {
	Create = function(p1, p2) --[[ Create | Line: 23 | Upvalues: v1 (copy) ]]
		local v12 = v1:Clone()

		v12.Name = p1
		v12.Adornee = p2
		v12.Enabled = true
		v12.Parent = v1.Parent

		return v12
	end,
	SetEnabled = function(p1, p2) --[[ SetEnabled | Line: 32 ]]
		p1.Enabled = p2
	end,
	ApplyMedia = function(p1, p2) --[[ ApplyMedia | Line: 36 | Upvalues: TreadmillVideoController (copy) ]]
		p1.VideoFrame.Image.Image = TreadmillVideoController.ResolveCoverImage(p2)
		p1.VideoFrame.StopPlay.Image = TreadmillVideoController.GetStoppedIconImage()
		p1.VideoFrame.StopPlay.Visible = true
	end
}

function t.ApplyFeed(p1, p2) --[[ ApplyFeed | Line: 45 | Upvalues: t (copy), TreadmillVideoController (copy) ]]
	t.ApplyMedia(p1, TreadmillVideoController.GetCurrentMediaEntry(p2))
end

return t