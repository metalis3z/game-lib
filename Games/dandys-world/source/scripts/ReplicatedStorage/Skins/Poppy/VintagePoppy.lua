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
-- CQMRBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRhyYnhhc3NldGlkOi8vMTc2NzU3MTAwMjIJVGV4dHVyZUlECUFwcGx5U2tpbg1WaW50YWdlIFBvcHB5BE5hbWUHTWFzdGVyeQZOb3JtYWwFQmxpbmsccmJ4YXNzZXRpZDovLzEwMjc5MDE0MzY3NjE5MwRIdXJ0GHJieGFzc2V0aWQ6Ly8xNzY3NTcxMjg3MQxGYWNlVGV4dHVyZXMTT3ZlcndyaXRlQW5pbWF0aW9ucwACCQEAAAAAEqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAggABAAcDAQQAAABAAwIDAwMEAwUDBgAQBwEYAAAAAAAAAAEAAAAAAQAA/gAFEgAAAAACAAABAgAUowAAAP8ABAAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAA4gEJADABACEKAAAA/wEAAAAAAAAwAQDpCwAAAMABDAAwAQDpDQAAAIIAAgAOAwgDCQMKAwsDBQMMAw0DDgMPCAMDBAAAAAUGAAAABwgAAAADEAMRBgADBwEAAQABGAAAAAIAAAEAAAQAAAYAAAACAAAJAQAAAAAB3RPgQz4zn4SeEiZb3ffCMq0L9zfv14pC

-- https://lua.expert/
return {
	Name = "Vintage Poppy",
	Mastery = true,
	FaceTextures = {
		Normal = "rbxassetid://17675710022",
		Blink = "rbxassetid://102790143676193",
		Hurt = "rbxassetid://17675712871"
	},
	OverwriteAnimations = {},
	ApplySkin = function(p1) --[[ ApplySkin | Line: 16 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://17675710022"
			end
		end
	end
}