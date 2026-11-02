-- Give item for cmdr made by "Kaiz" :D

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local NotificationService = require(ServerScriptService.Services.NotificationService)

return function(context, itemName)
	local player = context.Executor
	if not player then
		return "❌ This command must be executed by a player."
	end

	local ItemsFolder = ReplicatedStorage:FindFirstChild("Items")
	if not ItemsFolder then
		return "❌ Items folder not found in ReplicatedStorage."
	end

	local item = ItemsFolder:FindFirstChild(itemName)
	if not item then
		return "❌ Invalid item: " .. tostring(itemName)
	end

	local ok, err = pcall(function()
		local clone = item:Clone()
		clone.Parent = player:WaitForChild("Backpack")
		local clone2 = item:Clone()
		clone2.Parent = player:WaitForChild("StarterGear")
	end)

	if not ok then
		return "❌ Failed to give item: " .. tostring(err)
	end

-- This is to recolor the notify xddd (Made by kaiz tho).


	local function showRainbowItem(player, itemName)
		local gui = Instance.new("ScreenGui")
		gui.Name = "RainbowNotify"
		gui.ResetOnSpawn = false
		gui.Parent = player:WaitForChild("PlayerGui")

		local label = Instance.new("TextLabel")
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.Size = UDim2.new(0, 400, 0, 50)
		label.Position = UDim2.new(0.5, -200, 0.1, 0)
		label.BackgroundTransparency = 1
		label.TextScaled = true
		label.RichText = true
		label.Font = Enum.Font.SourceSansBold
		label.Text = "<b>You received: " .. itemName .. "</b>"
		label.Parent = gui

		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Color = Color3.fromRGB(0, 0, 0)
		stroke.Transparency = 0
		stroke.Parent = label

		-- here are the colors soo you can modify them
		local colors = {
			"#FF0000", -- red
			"#FF7F00", -- orange
			"#FFFF00", -- yellow
			"#00FF00", -- green
			"#0000FF", -- blue
			"#4B0082", -- indigo
			"#8B00FF", -- purple
		}

		local i = 1

		task.spawn(function()
			while label.Parent do
				local color = colors[i]
				label.Text = string.format("<b>You received: <font color='%s'>%s</font></b>", color, itemName)

				i = i + 1
				if i > #colors then i = 1 end
				task.wait(0.35) -- you can change this, change 0.2 to whatever you want
			end
		end)

		-- this removes the gui after 5 secs
		task.delay(7.5, function()
			gui:Destroy()
		end)
	end

	showRainbowItem(player, itemName)


	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= player then
			NotificationService.Notify(
				p,
				string.format("<font color='#ff69af'>%s</font> has received %s!", player.Name, itemName),
				5,
				"Sounds.Sfx.Success"
			)
		end
	end

	print(string.format("[GiveItem] %s received item %s.", player.Name, itemName))
	return "✅ Item has been given successfully!"
end
