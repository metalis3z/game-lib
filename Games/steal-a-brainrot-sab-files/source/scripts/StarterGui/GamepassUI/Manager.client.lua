local Player = game:GetService("Players").LocalPlayer
local Template = script:WaitForChild("Template")
local UI = script.Parent
local MainFrame = UI:WaitForChild("Frame")
local Toggle = UI:WaitForChild("Toggle")
local TweenService = game:GetService("TweenService")
local Debounce = false
local MarketplaceService = game:GetService("MarketplaceService")

local function CloseUI()
	local Tween = TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In, 0, false, 0), {Size = UDim2.new(0, 0, 0, 0)})
	Tween.Completed:Connect(function()
		MainFrame.Visible = false
	end)
	Tween:Play()
end

local GamepassRequests = UI:WaitForChild("Gamepasses")

local function CreateTemplate(Info, ID)
	-- Vérification que Info contient bien les champs nécessaires
	if not Info or not Info["Name"] or not Info["PriceInRobux"] or not Info["IconImageAssetId"] then
		warn("CreateTemplate: Info manquante ou invalide pour l'ID:", ID)
		return
	end

	local NewTemplate = Template:Clone()
	NewTemplate.Name = Info["Name"]
	NewTemplate.PriceBar.TextLabel.Text = tostring(Info["PriceInRobux"])  -- Convertir en string
	NewTemplate.TextLabel.Text = Info["Name"]
	NewTemplate.ImageLabel.Image = "rbxassetid://" .. tostring(Info["IconImageAssetId"])

	NewTemplate.TextButton.Activated:Connect(function()
		if Debounce == true then return end
		Debounce = true
		if script:FindFirstChild("Bell") then
			script["Bell"]:Play()
		end
		MarketplaceService:PromptGamePassPurchase(Player, ID)
		CloseUI()
		task.wait(0.65) 
		Debounce = false
	end)

	NewTemplate.TextButton.MouseEnter:Connect(function()
		TweenService:Create(NewTemplate.TextButton, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {Size = UDim2.new(0.95, 0, 0.95, 0)}):Play()
	end)

	NewTemplate.TextButton.MouseLeave:Connect(function()
		TweenService:Create(NewTemplate.TextButton, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {Size = UDim2.new(0.9, 0, 0.9, 0)}):Play()
	end)

	NewTemplate.Parent = MainFrame.List
end

-- Traitement des Gamepasses
for i, v in pairs(GamepassRequests:GetChildren()) do 
	if v:IsA("StringValue") then
		local ID = tonumber(v.Value)
		if not ID then
			warn("Gamepass Shop: "..v.Name.." a un ID invalide")
		else
			-- Utiliser pcall pour capturer les erreurs de GetProductInfo
			local success, Info = pcall(function()
				return MarketplaceService:GetProductInfo(ID, Enum.InfoType.GamePass)
			end)

			if not success or not Info then
				warn("Gamepass Shop: "..v.Name.." - Échec de récupération des infos (ID: "..ID..")")
			else
				CreateTemplate(Info, ID)
			end
		end
	else
		warn("Gamepass Shop: "..v.Name.." n'est pas un StringValue.")
	end
end

-- Bouton Toggle
Toggle.Activated:Connect(function()
	if Debounce == true then return end
	Debounce = true
	if script:FindFirstChild("Click") then
		script["Click"]:Play()
	end

	if MainFrame.Visible == true then
		CloseUI()
		task.wait(0.65) 
		Debounce = false
	else 
		MainFrame.Position = UDim2.new(0.5, 0, 0.425, 0)
		MainFrame.Size = UDim2.new(0.42, 0, 0.5, 0)
		TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
		MainFrame.Visible = true
		task.wait(0.35) 
		Debounce = false
	end
end)

-- Gamepasses de test (optionnel)
local TestGamepasses = 0
for i = 1, TestGamepasses do 
	local NewTemplate = Template:Clone()
	NewTemplate.Name = "Test Gamepass"
	NewTemplate.PriceBar.TextLabel.Text = "129"
	NewTemplate.TextLabel.Text = "Test 0"..i
	NewTemplate.TextButton.MouseEnter:Connect(function()
		TweenService:Create(NewTemplate.TextButton, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {Size = UDim2.new(0.95, 0, 0.95, 0)}):Play()
	end)
	NewTemplate.TextButton.MouseLeave:Connect(function()
		TweenService:Create(NewTemplate.TextButton, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {Size = UDim2.new(0.9, 0, 0.9, 0)}):Play()
	end)
	NewTemplate.LayoutOrder = 999
	NewTemplate.Parent = MainFrame.List
end