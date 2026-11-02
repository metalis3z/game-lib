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
-- CQMUGFRyYW5zZm9ybWF0aW9uQ2FtZXJhTG9jawxHZXRBdHRyaWJ1dGUKQ2FtZXJhVHlwZQRFbnVtClNjcmlwdGFibGUFcHJpbnQ1VHJhbnNmb3JtYXRpb25DYW1lcmFMb2NrOiBDYW1lcmEgbG9ja2VkIHRvIFNjcmlwdGFibGUsVHJhbnNmb3JtYXRpb25DYW1lcmFMb2NrOiBDYW1lcmEgcmVzdG9yZWQgdG8ETmFtZRlHZXRBdHRyaWJ1dGVDaGFuZ2VkU2lnbmFsB0Nvbm5lY3QQb25DaGFyYWN0ZXJBZGRlZARnYW1lB1BsYXllcnMKR2V0U2VydmljZQtMb2NhbFBsYXllcgl3b3Jrc3BhY2UNQ3VycmVudENhbWVyYQlDaGFyYWN0ZXIOQ2hhcmFjdGVyQWRkZWQAAwQAAwAAACL7AAAAbwIAALwAABIBAAAAnwADAg4ADgD7AQIATQEBKgIAAADeAQEA+wECAKQCBQAECDDAMAIBKgIAAACkAQcAAABgQG8CCACfAQIBggABAPsBAQAOAQsA+wECAPsCAQAwAgEqAgAAAKQBBwAAAGBAbwIJAPsDAQBNAwO6CgAAAJ8BAwGCAAEACwMBAwIDAwMEAwUEBAgwwAMGBAAAYEADBwMIAwkAEAABGAAAAAAAAgIAAAABAAAAAAEAAAAAAwABAAAAAQAAAAAAAAMRAAAAAAQBAgAAAAxvAwAAvAEAFgEAAACfAQMC2QMAABIAAAASAgAAEgIBALwBAccCAAAAnwEDAYIAAQADAwEDCgMLAQAODAEYAAAAAAAAAAAAAAAQEAAAAAAJAAABAgApowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAk0BADEEAAAApAIGAAAAUEBNAgJIBwAAAMYDAADZBAAAEgED/xIAAgBNBQFpCAAAAA4FDQBNBQFpCAAAAG8ICQC8BgUWCgAAAJ8GAwLZCAEAEgAFABIBA/8SAAIAvAYGxwsAAACfBgMBTQUBlwwAAABSBwQAvAUFxwsAAACfBQMBwQMAAIIAAQANAw0EAAAAQAMOAw8DEAMRBAAAUEADEgMTAwEDCgMLAxQCAQABAAEYAAYAAAAAAAEAAQAAAAIDAAAVAAABAOwAAAAAAAAAAAAAFwAAAAAAAQABAAAAAAIcXew8mb6lMdwSusG7JpIJbEX7SC6Zhj0=

-- https://lua.expert/
local LocalPlayer = game:GetService("Players").LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local v1 = nil

local function onCharacterAdded(p1) --[[ onCharacterAdded | Line: 14 | Upvalues: v1 (ref), CurrentCamera (copy) ]]
	p1:GetAttributeChangedSignal("TransformationCameraLock"):Connect(function() --[[ Line: 16 | Upvalues: p1 (copy), v1 (ref), CurrentCamera (ref) ]]
		if p1:GetAttribute("TransformationCameraLock") then
			v1 = CurrentCamera.CameraType
			CurrentCamera.CameraType = Enum.CameraType.Scriptable
			print("TransformationCameraLock: Camera locked to Scriptable")

			return
		end

		if not v1 then
			return
		end

		CurrentCamera.CameraType = v1
		print("TransformationCameraLock: Camera restored to", v1.Name)
	end)
end

if LocalPlayer.Character then
	local Character = LocalPlayer.Character

	Character:GetAttributeChangedSignal("TransformationCameraLock"):Connect(function() --[[ Line: 16 | Upvalues: Character (copy), v1 (ref), CurrentCamera (copy) ]]
		if Character:GetAttribute("TransformationCameraLock") then
			v1 = CurrentCamera.CameraType
			CurrentCamera.CameraType = Enum.CameraType.Scriptable
			print("TransformationCameraLock: Camera locked to Scriptable")

			return
		end

		if not v1 then
			return
		end

		CurrentCamera.CameraType = v1
		print("TransformationCameraLock: Camera restored to", v1.Name)
	end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)