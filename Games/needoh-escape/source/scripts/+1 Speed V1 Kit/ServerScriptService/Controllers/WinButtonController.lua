--!strict
-- LOCATION: ServerScriptService/Controllers/WinButtonController
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations)
local WinButtonController = {}
local PlayerController: any = nil
local SpeedRunController: any = nil   -- ADD
local giveWinsFolder = workspace:WaitForChild("GiveWins")
local startPart = workspace:WaitForChild("Start") :: BasePart
local function getAmountFromText(text: string): number
	text = string.gsub(text, "[^%d]", "")
	return tonumber(text) or 1
end
local function getButtonAmount(model: Model): number
	local touch = model:FindFirstChild("Touch")
	if not touch then return 1 end
	local gui = touch:FindFirstChild("GUI")
	if not gui then return 1 end
	local label = gui:FindFirstChild("WinAmount")
	if label and label:IsA("TextLabel") then
		return getAmountFromText(label.Text)
	end
	return 1
end
local function teleportToStart(character: Model)
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if rootPart and rootPart:IsA("BasePart") then
		rootPart.CFrame = startPart.CFrame + Vector3.new(0, 3, 0)
	end
end
local function setupButton(model: Model)
	local touchPart = model:WaitForChild("Touch") :: BasePart
	local debounce: {[number]: boolean} = {}
	touchPart.Touched:Connect(function(hit)
		local character = hit.Parent
		if not character then return end
		local player = game.Players:GetPlayerFromCharacter(character)
		if not player then return end
		if debounce[player.UserId] then return end
		debounce[player.UserId] = true

		-- Block win collection while SpeedRun is active
		if SpeedRunController and SpeedRunController:GetToggle(player) then
			PlayerController:Notify(player, "Turn off SpeedRun mode to collect Wins!", "Error")
			debounce[player.UserId] = nil   -- no cooldown penalty, let them try again
			return
		end

		-- X2 BUTTON
		if string.match(model.Name, "x2$") then
			local normalName = string.gsub(model.Name, "x2$", "")
			local normalButton = giveWinsFolder:FindFirstChild(normalName)
			if normalButton and normalButton:IsA("Model") then
				local amount = getButtonAmount(normalButton)
				if PlayerController and PlayerController.SetPendingX2TouchWins then
					PlayerController:SetPendingX2TouchWins(player, amount)
				end
				MarketplaceService:PromptProductPurchase(
					player,
					ProductConfigurations.X2TouchWinsId
				)
			end
			teleportToStart(character)
			task.delay(1.5, function() debounce[player.UserId] = nil end)
			return
		end

		-- NORMAL BUTTON
		local amount = getButtonAmount(model)
		if PlayerController then
			PlayerController:AddWins(player, amount)
		end
		teleportToStart(character)
		task.delay(1.5, function() debounce[player.UserId] = nil end)
	end)
end
function WinButtonController:Init(controllers)
	PlayerController    = controllers.PlayerController
	SpeedRunController  = controllers.SpeedRunController   -- ADD
end
function WinButtonController:Start()
	for _, child in ipairs(giveWinsFolder:GetChildren()) do
		if child:IsA("Model") then
			task.spawn(setupButton, child)
		end
	end
	giveWinsFolder.ChildAdded:Connect(function(child)
		if child:IsA("Model") then
			task.spawn(setupButton, child)
		end
	end)
end
return WinButtonController