-- BaseManagerController
-- Pilote la vraie GUI (instances Frame/Bouton créées dans l'Explorer) pour laisser
-- le joueur choisir sur quelle base libre déménager. Style et logique identiques
-- au reste du jeu (bases restant liées aux données du joueur -> brainrots conservés).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

local GetFreeBases = Net:RemoteFunction("BaseManagerService/GetFreeBases")
local RequestChangeBase = Net:RemoteEvent("BaseManagerService/RequestChangeBase")
local ChangeBaseResult = Net:RemoteEvent("BaseManagerService/ChangeBaseResult")

local ScreenGui = script.Parent
local ToggleButton = ScreenGui:WaitForChild("ToggleButton")
local Backdrop = ScreenGui:WaitForChild("Backdrop")
local MainFrame = Backdrop:WaitForChild("MainFrame")
local CloseButton = MainFrame:WaitForChild("CloseButton")

local ListFrame = MainFrame:WaitForChild("ListFrame")
local ScrollList = ListFrame:WaitForChild("ScrollList")
local ItemTemplate = ScrollList:WaitForChild("ItemTemplate")

local PreviewFrame = MainFrame:WaitForChild("PreviewFrame")
local PreviewLabel = PreviewFrame:WaitForChild("PreviewLabel")
local ConfirmButton = PreviewFrame:WaitForChild("ConfirmButton")

-- Black & White theme constants
local COLOR_ACTIVE = Color3.fromRGB(255, 255, 255)
local COLOR_ACTIVE_TEXT = Color3.fromRGB(0, 0, 0)
local COLOR_DISABLED = Color3.fromRGB(40, 40, 40)
local COLOR_DISABLED_TEXT = Color3.fromRGB(120, 120, 120)
local COLOR_ITEM = Color3.fromRGB(30, 30, 30)
local COLOR_ITEM_TEXT = Color3.fromRGB(255, 255, 255)
local COLOR_ITEM_SELECTED = Color3.fromRGB(255, 255, 255)
local COLOR_ITEM_SELECTED_TEXT = Color3.fromRGB(0, 0, 0)

local isOpen = false
local selectedId: string? = nil
local itemButtons: { [string]: TextButton } = {}

local function setConfirmEnabled(enabled: boolean)
	ConfirmButton.Active = enabled
	ConfirmButton.BackgroundColor3 = enabled and COLOR_ACTIVE or COLOR_DISABLED
	ConfirmButton.TextColor3 = enabled and COLOR_ACTIVE_TEXT or COLOR_DISABLED_TEXT
end

local function selectBase(id: string, label: string)
	selectedId = id
	for itemId, button in pairs(itemButtons) do
		if itemId == id then
			button.BackgroundColor3 = COLOR_ITEM_SELECTED
			button.TextColor3 = COLOR_ITEM_SELECTED_TEXT
			button.BackgroundTransparency = 0
		else
			button.BackgroundColor3 = COLOR_ITEM
			button.TextColor3 = COLOR_ITEM_TEXT
			button.BackgroundTransparency = 0.2
		end
	end
	PreviewLabel.Text = label
	setConfirmEnabled(true)
end

local function clearList()
	for _, child in ipairs(ScrollList:GetChildren()) do
		if child:IsA("TextButton") and child ~= ItemTemplate then
			child:Destroy()
		elseif child:IsA("TextLabel") and child.Name == "EmptyLabel" then
			child:Destroy()
		end
	end
	table.clear(itemButtons)
end

local function refreshList()
	clearList()
	selectedId = nil
	setConfirmEnabled(false)
	PreviewLabel.Text = "Choisis une base dans la liste"

	local ok, freeBases = pcall(function()
		return GetFreeBases:InvokeServer()
	end)

	if not ok or type(freeBases) ~= "table" then
		return
	end

	if #freeBases == 0 then
		local EmptyLabel = Instance.new("TextLabel")
		EmptyLabel.Name = "EmptyLabel"
		EmptyLabel.Size = UDim2.new(1, 0, 0, 40)
		EmptyLabel.BackgroundTransparency = 1
		EmptyLabel.Text = "Aucune base libre pour le moment"
		EmptyLabel.TextWrapped = true
		EmptyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		EmptyLabel.FontFace = ItemTemplate.FontFace
		EmptyLabel.TextSize = 14
		EmptyLabel.LayoutOrder = 0
		EmptyLabel.Parent = ScrollList
		return
	end

	for index, base in ipairs(freeBases) do
		local Item = ItemTemplate:Clone()
		Item.Name = base.Id
		Item.Text = base.Label
		Item.Visible = true
		Item.LayoutOrder = index
		Item.Parent = ScrollList

		itemButtons[base.Id] = Item

		Item.MouseButton1Click:Connect(function()
			selectBase(base.Id, base.Label)
		end)
	end
end

local function openGui()
	isOpen = true
	Backdrop.Visible = true
	refreshList()
end

local function closeGui()
	isOpen = false
	Backdrop.Visible = false
end

ToggleButton.MouseButton1Click:Connect(function()
	if isOpen then
		closeGui()
	else
		openGui()
	end
end)

CloseButton.MouseButton1Click:Connect(closeGui)

ConfirmButton.MouseButton1Click:Connect(function()
	if not selectedId or not ConfirmButton.Active then
		return
	end
	setConfirmEnabled(false)
	ConfirmButton.Text = "Déplacement..."
	RequestChangeBase:FireServer(selectedId)
end)

ChangeBaseResult.OnClientEvent:Connect(function(success: boolean, _errorMessage: string?)
	ConfirmButton.Text = "Rejoindre cette base"
	if success then
		closeGui()
	else
		setConfirmEnabled(selectedId ~= nil)
	end
end)
