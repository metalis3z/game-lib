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
-- CQMNCFNldHRpbmdzCVN0aWZmbmVzcwpFbGFzdGljaXR5BUJvbmVzC1BhcmVudEluZGV4CkZyZWVMZW5ndGgGQ0ZyYW1lA25ldwhQb3NpdGlvbg9UcmFuc2Zvcm1PZmZzZXQIUm90YXRpb24UTG9jYWxUcmFuc2Zvcm1PZmZzZXQJTWFnbml0dWRlAAISBQAAADMAAAwPDDIMDw0zCw8ONQkPChQqDwsrEw8JDD4PCj4MDwtBCQ8FAEsPBgJJDwcERw8IBkVLTQUDygAAAABNBgX8AQAAAE0HBRgCAAAATQkDeAMAAABNCgDNBAAAAIcICQoOCD4ATQkAfgUAAACMCgAAtwoEAAYAAACMCgAAYAorAAcAAACkCwgAABxggE0MCDsJAAAAnwsCAk0MCKYKAAAATQwMOAsAAAAJCgsMUgsCACsLCgCkDAgAABxggE0NAI0MAAAATQ0NOwkAAACfDAICCQsKDE0LCzsJAAAAUgILACYLAgEJDQcECQwLDUMBAQyMDAAAYAwNAAYAAAAmDAIBTQ0Mqg0AAAD1EA8GCQ8JEFsODw5gDgUADQAAACYRDQ7sEBENCQ8MEEMBAQ9NCwg7CQAAACYKCwFNCwqqDQAAAIwMAABgDAUACwAAACYOCwnsDQ4LCQwKDUMBAQyCAQIAEAMBAwIDAwMEAwUDBgMHAwgEABxggAMJAwoDCwMMAw0CAAAAAAAAAEACAAAAAAAA8D8AAgABGAAAAQABAAIAAAAAAgEAAgAAAAAAAQAAAAAAAAAAAAEAAAAAAAAAAAAAAAACAQAAAgAAAQEAAQAAAQABAAAABQAAAQABAAABAAAABQUAAAAAAQAAAQMAA6MAAADAAAAAggACAAEGAAEAAQABGAABAAEAAAAAAXmykuHREFxVdtIFcsYZ5HoJqoWVS3b44A==

-- https://lua.expert/
return function(p1, p2, p3, p4, p5) --[[ Line: 2 ]]
	local Settings = p4.Settings
	local Stiffness = Settings.Stiffness
	local Elasticity = Settings.Elasticity
	local v1 = p4.Bones[p1.ParentIndex]

	if v1 then
		local FreeLength = p1.FreeLength

		if Stiffness > 0 or Elasticity > 0 then
			local v2 = CFrame.new(v1.Position) * v1.TransformOffset.Rotation
			local v3 = if p3 then p3 else (v2 * CFrame.new(p1.LocalTransformOffset.Position)).Position

			p2 = p2 + (v3 - p2) * (Elasticity * p5)

			if Stiffness > 0 then
				local v4 = v3 - p2
				local Magnitude = v4.Magnitude
				local v5 = FreeLength * (1 - Stiffness) * 2

				if v5 < Magnitude then
					p2 = p2 + v4 * ((Magnitude - v5) / Magnitude)
				end
			end
		end

		local v6 = v1.Position - p2
		local Magnitude = v6.Magnitude

		if Magnitude > 0 then
			p2 = p2 + v6 * ((Magnitude - FreeLength) / Magnitude)
		end
	end

	return p2
end