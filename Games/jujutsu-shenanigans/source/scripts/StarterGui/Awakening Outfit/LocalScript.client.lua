local Player = game.Players.LocalPlayer
Player:WaitForChild('LoadedData')


-- Services

local Players = game.Players;
local IS = game.InsertService;
local AvatarEditor = game:GetService('AvatarEditorService');
local RS = game.ReplicatedStorage;
local TS = game.TweenService;


-- Remotes

local Remotes = RS.Remotes;


local PlrComs = Remotes.Comunicator;

local PlrSet = PlrComs.Set;
local PlrGet = PlrComs.Get;


-- Gui

local GUI = script.Parent
local MainFrame = GUI.Frame
local OutfitsScroll = MainFrame.ScrollingFrame


-- Variables

local selectedColor = Color3.fromRGB(255, 255, 255);
local unselectedColor = Color3.fromRGB(70, 70, 70);
local selectedOutfit, selectedMovesets = nil, {};
local hasPerms = false;


-- Functions

local function AddAppareance(Template: Model, OutfitId: number)
	PlrSet:FireServer('ApplyOutfit', { Hum = Template.Humanoid; Id = OutfitId; })
end

local function AddScrolls()
	local Outfits = AvatarEditor:GetOutfits(Enum.OutfitSource.Created, Enum.OutfitType.Avatar):GetCurrentPage();
	for _,v in Outfits do
		local Button = script.TextButton:Clone()
		Button.Text = v.Name
		Button.Activated:Connect(function()
			AddAppareance(MainFrame.ViewportFrame.WorldModel.Preview, v.Id)
			selectedOutfit = v.Id
		end)
		Button.Parent = OutfitsScroll
	end
	
	OutfitsScroll.CanvasSize = UDim2.new(0, 0, 0, 13 * #OutfitsScroll:GetChildren())
	
	AddAppareance(MainFrame.ViewportFrame.WorldModel.Preview, Outfits[1].Id)
	selectedOutfit = Outfits[1].Id
end


-- Runtime

local hasOutfitPerms = pcall(function()
	AvatarEditor:GetOutfits()
end)

if hasOutfitPerms then
	AddScrolls()
else
	AvatarEditor.PromptAllowInventoryReadAccessCompleted:Connect(function(result)
		if result == Enum.AvatarPromptResult.Success then
			hasPerms = true

			AddScrolls()
		else
			GUI.Enabled = false
		end
	end)
end

local charsCount, defaultXSize = 0, nil;
for Name, Info in game.HttpService:JSONDecode(Player:GetAttribute('Characters')) do
	local Order = tonumber(Info.order)
	local imageId = tostring(Info.icon)

	local Icon = script.MovesetTemplate:Clone()
	Icon.Image = "rbxassetid://" .. imageId
	Icon.LayoutOrder = Order
	Icon.Parent = MainFrame.Characters
	
	Icon.Activated:Connect(function()
		local isSelected = table.find(selectedMovesets, Name)

		if isSelected ~= nil then
			TS:Create(Icon, TweenInfo.new(.5), { ImageColor3 = unselectedColor; }):Play()

			table.remove(selectedMovesets, isSelected)
		else
			TS:Create(Icon, TweenInfo.new(.5), { ImageColor3 = selectedColor; }):Play()

			table.insert(selectedMovesets, Name)
		end
	end)
	
	
	charsCount += 1;

	if not defaultXSize then
		defaultXSize = Icon.Size.X.Offset/2
	end
end


MainFrame.Characters.CanvasSize = UDim2.new(0, defaultXSize * charsCount, 0, 0)

MainFrame.Apply.Activated:Connect(function()
	if #selectedMovesets == 0 or not selectedOutfit then return end
	print(selectedMovesets)
	PlrSet:FireServer('SetAwkOutfit', { Movesets = selectedMovesets; OutfitId = selectedOutfit; })
end)

GUI:GetPropertyChangedSignal('Enabled'):Connect(function()
	if GUI.Enabled == true and hasPerms == false then
		AvatarEditor:PromptAllowInventoryReadAccess()
	end
end)