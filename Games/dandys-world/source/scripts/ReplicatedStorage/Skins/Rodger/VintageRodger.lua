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
-- CQMZBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQhNYXRlcmlhbARFbnVtDVNtb290aFBsYXN0aWMccmJ4YXNzZXRpZDovLzEwMzg1OTM0NjYxODQ3OQlUZXh0dXJlSUQJSGVhZEdsYXNzBURlY2FsHHJieGFzc2V0aWQ6Ly8xNDAzMzg5ODYwNDY1ODcHVGV4dHVyZQRIZWFkBE5hbWUBXwZDb25maWcMV2FpdEZvckNoaWxkDU5vcm1hbFRleHR1cmULSHVydFRleHR1cmUMQmxpbmtUZXh0dXJlG3JieGFzc2V0aWQ6Ly85NjIzNDI1ODE5MzI2ORxyYnhhc3NldGlkOi8vMTE1ODQxODMwMjU0OTg1CUFwcGx5U2tpbg5WaW50YWdlIFJvZGdlcgACCQEAAAAAQKQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBDgBvCAMAvAYF/gQAAACfBgMCDgYJAE0GBS0FAAAApAcIAAcUYMDxBgQABwAAAG8GCQAwBgWECgAAAG4B8f8CAAAATQEAzAsAAABNAQGgDAAAAG8CDQAwAgFPDgAAAE0BABMPAAAATQMBuhAAAABvBBEAcwIDBDACAboQAAAAbwMSALwBANMTAAAAnwEDAm8EFAC8AgHTEwAAAJ8CAwJvBRUAvAMB0xMAAACfAwMCbwYWALwEAdMTAAAAnwQDAm8FFwAwBQRPDgAAAG8FGAAwBQNPDgAAAG8FDQAwBQJPDgAAAIIAAQAZAwEEAAAAQAMCAwMDBAMFAwYDBwQHFGDAAwgDCQMKAwsDDAMNAw4DDwMQAxEDEgMTAxQDFQMWAxcABRgBGAAAAAAAAAABAAAAAAAAAAAAAAEAAP4ABgAAAAAAAAEAAAAAAAAAAgAAAAEAAAABAAAAAQAAAAIAAAEAAAEAAAIHAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMZAw8GAAMYAQABAAEYAAAAAgAAAgAAGAEAAAAAAf/VcXe0LImavCO6icTHjImPzWYDzREbdg==

-- https://lua.expert/
return {
	Name = "Vintage Rodger",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") and v.Material ~= Enum.Material.SmoothPlastic then
				v.TextureID = "rbxassetid://103859346618479"
			end
		end

		p1.HeadGlass.Decal.Texture = "rbxassetid://140338986046587"

		local Head = p1.Head

		Head.Name = Head.Name .. "_"

		local Config = p1:WaitForChild("Config")
		local NormalTexture = Config:WaitForChild("NormalTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")

		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://96234258193269"
		HurtTexture.Texture = "rbxassetid://115841830254985"
		NormalTexture.Texture = "rbxassetid://140338986046587"
	end
}