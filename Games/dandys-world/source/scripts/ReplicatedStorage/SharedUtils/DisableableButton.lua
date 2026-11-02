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
-- CQMVCERpc2FibGVkDEdldEF0dHJpYnV0ZQZBY3RpdmUMSW50ZXJhY3RhYmxlEFRleHRUcmFuc3BhcmVuY3kGQ29sb3IzA25ldwFSAUcBQgtJbWFnZUNvbG9yMwVhcHBseQtJbWFnZUJ1dHRvbgNJc0EKSW1hZ2VMYWJlbBZGaW5kRmlyc3RDaGlsZFdoaWNoSXNBCVRleHRMYWJlbBlHZXRBdHRyaWJ1dGVDaGFuZ2VkU2lnbmFsB0Nvbm5lY3QMU2V0QXR0cmlidXRlCFJlZ2lzdGVyAQYAAwcABAAAADf7AQAAbwMAALwBARIBAAAAnwEDAioBAgABAAAAqQAAAakAAQD7AQAAVgIAADACAYMCAAAA+wEAAFYCAAAwAgHEAwAAAPsBAQAOASMA+wECAA4BIQD7AQMADgEHAPsBAwAOAAIAbwIEAGUAAQCMAgAAMAIBJAUAAAAOABMA+wECAKQCCAAAHGCA+wQBAE0EBHMKAAAAWwMECfsFAQBNBQVmCwAAAFsEBQn7BgEATQYGYwwAAABbBQYJnwIEAjACAQANAAAAggABAPsBAgD7AgEAMAIBAA0AAACCAAEADgMBAwIDAwMEAmZmZmZmZuY/AwUDBgMHBAAcYIACAAAAAAAA4D8DCAMJAwoDCwA4DAEYAAAAAAAAAAAAAQAAAAEAAAABAAAAAQABAAAAAAAAAgEAAAEAAAABAAAAAQAAAP0AAAAGAAAAAzkAAAAADgIAAAAHBAAABQIEBzcrAQIAxgIAAIICAgDGAgAAxgMAAG8GAAC8BAH+AQAAAJ8EAwIOBAQATQIBAAIAAABSAwEAZQAIAG8GAwC8BAFUBAAAAJ8EAwIOBAMATQIEAAIAAABSAwQAbwYFALwEAVQEAAAAnwQDAtkFAAASAAEAEgEC/xIBA/8SAAQAbwgGALwGARYHAAAAnwYDAlIIBQC8BgbHCAAAAJ8GAwJvCQYAbw0GALwLARIJAAAAnwsDAioLAgABAAAAqQoAAakKAQC8BwEuCgAAAJ8HBAFSBwUAnwcBAcECAACCBgIACwMNAw4DCwMPAxADEQMBAxIDEwMCAxQBACUVARgAAAACAQIAAAAAAQABAAIAAAABAQABBAAAAAIAAAAAFAAAAAAAAAAEAAAAAAAAAAAAAAABAAIAJgAAAAACAAABAgAHowAAAP8AAQAAAAAAwAEAADABAIMBAAAAggACAAIGAQMVAQEBAAEYABcADQAAMQEAAAAAApNE5F43cXM0ANgfkfiCWR/jXPMqoYCOXw==

-- https://lua.expert/
return {
	Register = function(p1, p2) --[[ Register | Line: 37 ]]
		if not p2 then
			return nil
		end

		local v1 = nil
		local v2 = nil

		if p2:IsA("ImageButton") then
			v1 = p2.ImageColor3
			v2 = p2
		else
			local v3 = p2:FindFirstChildWhichIsA("ImageLabel")

			if v3 then
				v1 = v3.ImageColor3
				v2 = v3
			end
		end

		local v4 = p2:FindFirstChildWhichIsA("TextLabel")

		local function apply() --[[ apply | Line: 56 | Upvalues: p2 (copy), v1 (ref), v2 (ref), v4 (copy) ]]
			local v12 = p2:GetAttribute("Disabled") == true

			p2.Active = not v12
			p2.Interactable = not v12

			if not (v1 and v2) then
				return
			end

			if v4 then
				v4.TextTransparency = if v12 then 0.7 else 0
			end

			if v12 then
				v2.ImageColor3 = Color3.new(v1.R * 0.5, v1.G * 0.5, v1.B * 0.5)

				return
			end

			v2.ImageColor3 = v1
		end

		local v5 = p2:GetAttributeChangedSignal("Disabled"):Connect(apply)

		p2:SetAttribute("Disabled", p2:GetAttribute("Disabled") == true)
		apply()

		return v5
	end
}