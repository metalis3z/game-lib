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
-- CQMYBlBhcmVudAdFbmFibGVkCkRpc2Nvbm5lY3QIUm90YXRpb24EZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2ULTG9jYWxQbGF5ZXIKUGxheWVyRGF0YQZVc2VySWQIdG9zdHJpbmcORmluZEZpcnN0Q2hpbGQKUnVuU2VydmljZQZzY3JpcHQEdGFzawR3YWl0D0hpZ2hsaWdodFRvZ2dsZQxXYWl0Rm9yQ2hpbGQFVmFsdWUFRnJhbWUKSW1hZ2VMYWJlbAlIZWFydGJlYXQHQ29ubmVjdAACBgEDAAAAG/sBAAAOAQgA+wEAAE0BASQAAAAADgEEAPsBAABNAQHwAQAAACsBBwD7AQEAvAEBGgIAAACfAQIBxgEAAN4BAQCCAAEA+wECAPsEAgBNBAQ4BAAAAFsFAAVDAwQFIQIDAzACATgEAAAAggABAAYDAQMCAwMCAAAAAACAdkADBAIAAAAAAIBmQAAbAAEYAAAAAAAAAAAAAAEAAAABAAECAAAAAAAAAAABHAAAAAAMAAABAABYowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAk0CADEFAAAATQMB9gYAAABNBgLmBwAAALs/BgKkBQkAAACAQJ8FAgK8AwMDCgAAAJ8DAwKkBAEAAAAAQG8GCwC8BAQWAwAAAJ8EAwKkBQ0AAADAQE0FBSQOAAAAKwMVAKQGEQAAQPCAjAcBAJ8GAgGkBgEAAAAAQE0GBj8EAAAATQYG9gYAAABNCQLmBwAAALs/CQKkCAkAAACAQJ8IAgK8BgYDCgAAAJ8GAwJSAwYASADq/ysDAQCCAAEAbwgSALwGA9MTAAAAnwYDAk0HBuwUAAAAKwcBAIIAAQCpBwEAMAcF8BUAAADGBwAATQgFnRYAAABNCAgvFwAAAE0JBP0YAAAA2QsAABIABQASAQf/EgAIALwJCccZAAAAnwkDAlIHCQDBBwAAggABABoDBQQAAABAAwYDBwMIAwkDCgMLAwwEAACAQAMNAw4DDwQAAMBAAwEDEAMRBABA8IADEgMTAxQDAgMVAxYDFwMYAQABAAEYAAAAAAAAAAEAAAAAAAIAAQAAAAAAAAAAAAABAAAAAAACAAAAAgEAAAABAAAAAAAAAAAAAAAAAAAA/gUAAgAAAAIAAAACAAACAQAAAAMAAAAAAAAAAAAIAAEAAAAAAW9O+AhymMHy4GP38XloddofVu98XYqSCQ==

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local v1 = ReplicatedStorage.PlayerData:FindFirstChild((tostring(LocalPlayer.UserId)))
local RunService = game:GetService("RunService")
local v2 = script.Parent

while not v1 do
	task.wait(1)
	v1 = game.ReplicatedStorage.PlayerData:FindFirstChild((tostring(LocalPlayer.UserId)))
end

if not v1 then
	return
end

if v1:WaitForChild("HighlightToggle").Value then
	v2.Enabled = true

	local v4 = nil
	local ImageLabel = v2.Frame.ImageLabel

	v4 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 27 | Upvalues: v2 (copy), v4 (ref), ImageLabel (copy) ]]
		if v2 and (v2.Parent and v2.Enabled) then
			ImageLabel.Rotation = (ImageLabel.Rotation + p1 * 180) % 360
		else
			v4:Disconnect()
			v4 = nil
		end
	end)
end