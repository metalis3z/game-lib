local Module = {}
local SyncedData = {}
_G.EmotePages = {}
_G.CurrentPage = ""
Module.EmoteGUI = nil
local MyEmotes = {}
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId="
local function GetImage(Image)
	if _G.Cache[Image] ~= nil then
		return _G.Cache[Image]
	end
	local NewImage = (tonumber(Image) and AssetURL.. Image or Image) .. "&bust=" .. math.random(1, 10000)
	_G.Cache[Image] = NewImage
	return NewImage
end
local KeyboardEnabled = game:GetService("UserInputService").KeyboardEnabled
Module.GeneratePage = function(setEmotes, allEmotes, emoteName, otherEmotesFunc, otherEmotesFunc2)
	local NewFrame = script.Page:Clone()
	local NewContainer = script.Container:Clone()
	NewContainer.Parent = NewFrame
	NewFrame.Name = emoteName
	NewFrame.Parent = allEmotes.EmotePages
	local EmoteAdder = {}
	for Emote, AllEmotes in pairs(setEmotes) do
		EmoteAdder[Emote] = AllEmotes
	end
	table.insert(EmoteAdder, 1, "")
	table.insert(EmoteAdder, 2, "")
	MyEmotes[emoteName] = {}
	local Sizer = #EmoteAdder - 2
	NewContainer.Size = UDim2.new(Sizer, 0, 1, 0)
	NewContainer:ClearAllChildren()
	local MaxPages = 3
	for _, Emote in pairs(EmoteAdder) do
		if _G.Database.Emotes[Emote] then
			local EmoteFrame = script.Emote:Clone()
			EmoteFrame.Size = UDim2.new(1 / Sizer, 0, 1, 0)
			EmoteFrame.Position = UDim2.new(1 / Sizer * (MaxPages - 1 - 1 - 1), 0, 0, 0)
			EmoteFrame.Name = Emote
			EmoteFrame.Parent = NewContainer
			EmoteFrame.Container.Icon.Image = GetImage(_G.Database.Emotes[Emote].Image)
			EmoteFrame.Container.EmoteName.Text = _G.Database.Emotes[Emote].Name
			EmoteFrame.Container.Hotkey.Text = MaxPages
			EmoteFrame.Container.Hotkey.Visible = KeyboardEnabled
			EmoteFrame.Container.Button.MouseButton1Click:connect(function()
				game.ReplicatedStorage.PlayEmote:Fire(Emote)
			end)
			MyEmotes[emoteName][MaxPages] = Emote
			MaxPages = MaxPages + 1
		end
	end
	table.insert(_G.EmotePages, emoteName)
	local BackFrame = script.Back:Clone()
	BackFrame.Size = UDim2.new(1 / Sizer, 0, 1, 0)
	BackFrame.Container.Icon.Visible = not game:GetService("UserInputService").GamepadEnabled
	BackFrame.Container.BButton.Visible = game:GetService("UserInputService").GamepadEnabled
	BackFrame.Container.Hotkey.Visible = game:GetService("UserInputService").KeyboardEnabled
	BackFrame.Parent = NewContainer
end
Module.ShowPage = function(page)
	_G.EmoteController.Emotes = { nil, "Back" }
	for ownedEmotes, emoteOnPage in pairs(MyEmotes[page]) do
		_G.EmoteController.Emotes[ownedEmotes] = emoteOnPage
	end
	for _, v in pairs(Module.EmoteGUI.EmotePages:GetChildren()) do
		v.Visible = v.Name == page
	end
	_G.CurrentPage = page
	Module.EmoteGUI.PageName.Text = page
	if game:GetService("UserInputService").GamepadEnabled and Module.EmoteGUI.Visible then
		game:GetService("GuiService").SelectedObject = Module.EmoteGUI.EmotePages[page].Container:GetChildren()[1].Container.Button
	end
end
_G.ChangePage = function(page)
	for currentPage, nextPage in pairs(_G.EmotePages) do
		if currentPage == page then
			Module.ShowPage(nextPage)
		end
	end
end
local PlayerData = {}
Module.GenerateEmotes = function(emotesOnPage, leftAndRight)
	MyEmotes = {}
	_G.EmotePages = {}
	_G.CurrentPage = ""
	leftAndRight.EmotePages:ClearAllChildren()
	if #emotesOnPage > 0 then
		if #emotesOnPage > 6 then
			local yourEmotes = {}
			local emotesYouOwn = 0
			for usingMath, usingMath2 in pairs(emotesOnPage) do
				local mathFloor = math.floor(usingMath / 6) + 1
				yourEmotes[mathFloor] = yourEmotes[mathFloor] or {}
				table.insert(yourEmotes[mathFloor], usingMath2)
				emotesYouOwn = mathFloor
			end
			local controls
			for pageNumber, allEmotes in pairs(yourEmotes) do
				local switch = "Your Emotes (" .. pageNumber .. "/" .. emotesYouOwn .. ")"
				Module.GeneratePage(allEmotes, leftAndRight, switch)
				if pageNumber == 1 then
					controls = switch
				end
			end
			Module.GeneratePage({ "wave", "cheer", "laugh", "dance1", "dance2", "dance3" }, leftAndRight, "Roblox Emotes")
			Module.ShowPage(controls, leftAndRight)
		else
			Module.GeneratePage(emotesOnPage, leftAndRight, "Your Emotes")
			Module.GeneratePage({ "wave", "cheer", "laugh", "dance1", "dance2", "dance3" }, leftAndRight, "Roblox Emotes")
			Module.ShowPage("Your Emotes", leftAndRight)
		end
	else
		Module.GeneratePage({ "wave", "cheer", "laugh", "dance1", "dance2", "dance3" }, leftAndRight, "Roblox Emotes")
		Module.GeneratePage(emotesOnPage, leftAndRight, "Your Emotes")
		Module.ShowPage("Roblox Emotes", leftAndRight)
	end
	PlayerData = {}
	for _, p in pairs(emotesOnPage) do
		PlayerData[p] = true
	end
end
local GamepadEnabled = game:GetService("UserInputService").GamepadEnabled
function Module.SetupPageButtons()
	local pageSwitcher
	local pageSwitcher2
	if GamepadEnabled then
		pageSwitcher = "< LB"
	elseif KeyboardEnabled then
		pageSwitcher = "< Q"
	else
		pageSwitcher = "<"
	end
	if GamepadEnabled then
		pageSwitcher2 = "RB >"
	elseif KeyboardEnabled then
		pageSwitcher2 = "E >"
	else
		pageSwitcher2 = ">"
	end
	Module.EmoteGUI.Left.Text = pageSwitcher
	Module.EmoteGUI.Right.Text = pageSwitcher2
	Module.EmoteGUI.Left.MouseButton1Click:connect(_G.EmotePageLeft)
	Module.EmoteGUI.Right.MouseButton1Click:connect(_G.EmotePageRight)
end
game.ReplicatedStorage.UpdateDataClient.Event:connect(function(Data)
	if Data then return end
	for _, HasEmotes in pairs(_G.PlayerData.Emotes.Owned) do
		if PlayerData[HasEmotes] == nil then
			Module.GenerateEmotes(_G.PlayerData.Emotes.Owned, Module.EmoteGUI)
			return
		end
	end
end)
return Module