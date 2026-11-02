local ToolService = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local UseItemFunction = Net:RemoteFunction("UseItem")
local UseItemEvent = Net:RemoteEvent("UseItem")
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")
local playerConnections = {}

function ToolService.Create(player, tool: string)
	local toolModel: Tool? = ReplicatedStorage.Items:FindFirstChild(tool)
	if not toolModel then
		return
	end

	local data = Synchronizer:Get(player)
	if not data then
		return
	end

	toolModel = toolModel:Clone()
	toolModel.Parent = player.Backpack

	for _, obj in ipairs(toolModel:GetDescendants()) do
		if obj:IsA("Script") or obj:IsA("LocalScript") then
			if obj.Name == "RemovalMonitor" then
				obj.Enabled = false
			else
				obj.Enabled = true
			end
		end
	end

	toolModel.DescendantAdded:Connect(function(obj)
		if obj:IsA("Script") or obj:IsA("LocalScript") then
			if obj.Name == "RemovalMonitor" then
				obj.Enabled = false
			else
				obj.Enabled = true
			end
		end
	end)
end

function setupCharacter(player: Player, character: Model)
	local playerChannel = Synchronizer:Wait(player)
	if not playerChannel then
		return
	end
	local Items = playerChannel:Get("Items")
	if not Items then
		return
	end
	for tool in pairs(Items) do
		ToolService.Create(player, tool)
	end
	if playerConnections[player] then
		playerConnections[player]:Disconnect()
		playerConnections[player] = nil
	end
	playerConnections[player] = playerChannel:OnDictionaryInserted("Items", function(_, tool: string)
		ToolService.Create(player, tool)
	end)
	character:SetAttribute("BackpackReady", true)
end

function setupPlayer(player: Player)
	if player and player.Character then
		setupCharacter(player, player.Character)
	end
	player.CharacterAdded:Connect(function(character: Model)
		setupCharacter(player, character)
	end)
end

function ToolService:Start()
	for _, player: Player in pairs(Players:GetPlayers()) do
		setupPlayer(player)
	end
	Players.PlayerAdded:Connect(setupPlayer)
	Players.PlayerRemoving:Connect(function(player: Player) 
		if playerConnections[player] then
			playerConnections[player]:Disconnect()
			playerConnections[player] = nil
		end
	end)

	UseItemEvent.OnServerEvent:Connect(function(player: Player, ...)
		local character = player.Character
		if not character then
			return
		end
		local tool = character:FindFirstChildOfClass("Tool")
		if not tool then
			local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
			if not backpackTool then
				return
			end
			tool = backpackTool
		end
		local toolsFolder = script:FindFirstChild("Tools")
		if not toolsFolder then
			return
		end
		local toolScript = toolsFolder:FindFirstChild(tool.Name)
		if not toolScript then
			return
		end
		local args = {...}
		local success, _ = pcall(function()
			local toolModule = require(toolScript)
			if toolModule.OnExecution then
				toolModule.OnExecution(player, character, tool, table.unpack(args))
			end
		end)
	end)

	UseItemFunction.OnServerInvoke = function(player: Player)
		local character = player.Character
		if not character then
			return nil
		end

		local tool = character:FindFirstChildOfClass("Tool")
		if not tool then
			local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
			if not backpackTool then
				return nil
			end
			tool = backpackTool
		end

		local toolsFolder = script:FindFirstChild("Tools")
		if not toolsFolder then
			return nil
		end

		local toolScript = toolsFolder:FindFirstChild(tool.Name)
		if not toolScript then
			return nil
		end

		local success, result = pcall(function()
			local toolModule = require(toolScript)
			if toolModule.OnExecution then
				return toolModule.OnExecution(player, character, tool)
			end
		end)

		if success then
			return result
		else
			return nil
		end
	end
end

return ToolService