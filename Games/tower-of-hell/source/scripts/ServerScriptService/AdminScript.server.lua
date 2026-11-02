-- Admin pranvexploder for Ph4ntomize
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local commands = ServerStorage.AdminCommands

-- Settings
local Admins = {"NINJA_LEGEND0273, "NINJA_LEGEND0273"}
local prefix = "/" -- Change this to the starting character

game.Players.PlayerAdded:Connect(function(Player)
	Player.Chatted:Connect(function(message)
		if not table.find(Admins, Player.Name) then return end
		if message:sub(1, #prefix) ~= prefix then return end

		local args = message:split(" ")
		local cmd = args[1]:sub(#prefix + 1, #args[1]):lower()
		table.remove(args, 1)

		if not commands:FindFirstChild(cmd) then return end
		spawn(function()
			require(commands[cmd]).run(Player, message, args)
		end)
	end)
end)