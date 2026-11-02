
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local net = require(ReplicatedStorage.Packages.Net)
local GiveItemRemote = net:RemoteFunction("GiveGear")
local TakeItemRemote = net:RemoteFunction("TakeGear")
local NotificationService = require(ServerScriptService.Services.NotificationService)

local function giveitem(player, itemName)
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
end

local function takeitem(player, itemName)
	if not player then
		return "❌ This command must be executed by a player."
	end

	local backpack = player:FindFirstChild("Backpack")
	local starterGear = player:FindFirstChild("StarterGear")
	local character = player.Character

	local found = false

	local ok, err = pcall(function()
		if backpack then
			local item = backpack:FindFirstChild(itemName)
			if item then
				item:Destroy()
				found = true
			end
		end

		if starterGear then
			local item = starterGear:FindFirstChild(itemName)
			if item then
				item:Destroy()
				found = true
			end
		end

		if character then
			local item = character:FindFirstChild(itemName)
			if item and item:IsA("Tool") then
				item:Destroy()
				found = true
			end
		end
	end)

	if not ok then
		return "❌ Failed to remove item: " .. tostring(err)
	elseif not found then
		return "⚠️ Item '" .. tostring(itemName) .. "' not found in player's inventory."
	else
		return "✅ Successfully removed " .. tostring(itemName) .. " from " .. player.Name
	end
end

GiveItemRemote.OnServerInvoke = giveitem
TakeItemRemote.OnServerInvoke = takeitem
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

		local colors = {
			"#FF0000",
			"#FF7F00",
			"#FFFF00",
			"#00FF00",
			"#0000FF",
			"#4B0082",
			"#8B00FF",
		}

		local i = 1

		task.spawn(function()
			while label.Parent do
				local color = colors[i]
				label.Text = string.format("<b>You received: <font color='%s'>%s</font></b>", color, itemName)

				i = i + 1
				if i > #colors then i = 1 end
				task.wait(0.35)
			end
		end)

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
