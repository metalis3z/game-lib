local CharacterService = {}
local Timers = {}

local Players = game:GetService("Players")
local BordersModel = workspace.Map:WaitForChild("Borders")

local function GetModelCenter(Model)
	if not Model.PrimaryPart then
		Model.PrimaryPart = Model:FindFirstChildWhichIsA("BasePart")
	end

	if Model.PrimaryPart then
		return Model.PrimaryPart.Position
	end

	return Model:GetPivot().Position
end

local function SetupCharacter(Player, Character)
	local Humanoid = Character:WaitForChild("Humanoid")
	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

	Humanoid.BreakJointsOnDeath = false

	Humanoid.Died:Connect(function()
		Player:SetAttribute("Stealing", false)
	end)

	task.spawn(function()
		while Character.Parent and Player.Parent do
			task.wait(0.1)

			local Center = GetModelCenter(BordersModel)
			local Distance = (HumanoidRootPart.Position - Center).Magnitude

			if Distance > 700 then
				Timers[Player.UserId] = (Timers[Player.UserId] or 0) + 0.1

				if Timers[Player.UserId] >= 1 then
					Player:LoadCharacter()
					Timers[Player.UserId] = 0
					break
				end
			else
				Timers[Player.UserId] = 0
			end
		end
	end)
end

local function ForceUnequip(Player, Character)
	local Backpack = Player:WaitForChild("Backpack")

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		Humanoid:UnequipTools()
	end

	for _, tool in ipairs(Character:GetChildren()) do
		if tool:IsA("Tool") then
			tool.Parent = Backpack
		end
	end
end

local function SetupToolLock(Player, Character)
	local Backpack = Player:WaitForChild("Backpack")

	if Player:GetAttribute("Stealing") == true then
		ForceUnequip(Player, Character)
	end

	Character.ChildAdded:Connect(function(child)
		if child:IsA("Tool") and Player:GetAttribute("Stealing") == true then
			task.defer(function()
				child.Parent = Backpack
			end)
		end
	end)

	Player:GetAttributeChangedSignal("Stealing"):Connect(function()
		if Player:GetAttribute("Stealing") == true then
			ForceUnequip(Player, Character)
		end
	end)
end

local function OnPlayerAdded(Player)
	if Player:GetAttribute("Stealing") == nil then
		Player:SetAttribute("Stealing", false)
	end

	Timers[Player.UserId] = 0

	Player.CharacterAdded:Connect(function(Character)
		SetupCharacter(Player, Character)
		SetupToolLock(Player, Character)
	end)
end

local function OnPlayerRemoving(Player)
	Timers[Player.UserId] = nil
end

function CharacterService.Start()
	Players.PlayerAdded:Connect(OnPlayerAdded)
	Players.PlayerRemoving:Connect(OnPlayerRemoving)

	for _, Player in ipairs(Players:GetPlayers()) do
		OnPlayerAdded(Player)
	end
end

return CharacterService