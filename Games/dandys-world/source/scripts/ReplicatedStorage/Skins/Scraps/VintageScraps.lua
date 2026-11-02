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
-- CQMVBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRhyYnhhc3NldGlkOi8vMTc2NjE1MTc1NzkJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUYcmJ4YXNzZXRpZDovLzE3NjYxNTIwODk5B1RleHR1cmUNTm9ybWFsVGV4dHVyZQlBcHBseVNraW4OUm9wZUNvbnN0cmFpbnQKQnJpY2tDb2xvcgNuZXcGRm9zc2lsBUNvbG9yClVzZUFiaWxpdHkOVmludGFnZSBTY3JhcHMETmFtZQADCQEAAAAAJKQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvAwoAMAMCTwsAAABvBQwAvAMB0wgAAACfAwMCbwQFADAEA08LAAAAggABAA0DAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAAGDQEYAAAAAAAAAAEAAAAAAQAA/gAGAAAAAQAAAAIAAAIAAAACAAABBwAAAAAJAQAAAAAepAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEUAG8IAwC8BgX+BAAAAJ8GAwIOBgQAbwYFADAGBYQGAAAAZQALAG8IBwC8BgX+BAAAAJ8GAwIOBgYApAYKAAAkgIBvBwsAnwYCAjAGBaQMAAAAbgHr/wIAAACCAAEADQMBBAAAAEADAgMDAwQDBQMGAw4DDwMQBAAkgIADEQMSABcTARgAAAAAAAAAAQAAAAABAAAAAQAAAAABAAAAAAD8AAcYAAAAAAIAAAECAA2jAAAA/wADAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAADAAQQAMAEAsgUAAACCAAIABgMUAxUGAAMNBgEDEwIAAQEAARgAAAACAAADAAARAAAMAQAAAAACyjwqe13GzgdbsnutKQvKS7okPQ/4+EB6

-- https://lua.expert/
return {
	Name = "Vintage Scraps",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://17661517579"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://17661520899"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://17661517579"
	end,
	UseAbility = function(p1) --[[ UseAbility | Line: 23 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://17661517579"

				continue
			end

			if v:IsA("RopeConstraint") then
				v.Color = BrickColor.new("Fossil")
			end
		end
	end
}