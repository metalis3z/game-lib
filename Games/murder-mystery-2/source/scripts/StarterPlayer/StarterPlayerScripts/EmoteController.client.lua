while true do
	wait()
	if _G.PlayerData and game.Players.LocalPlayer.Character then
		break
	end
end
local EmotesGui = script.Emotes:Clone()
EmotesGui.D.Disabled = false
EmotesGui.Parent = game.Players.LocalPlayer.Backpack
_G.EmoteController = {}
_G.EmoteController.Emotes = {}
local ContextActionService = game:GetService('ContextActionService')
local Emotes = {}
local ActionEmotes = {}
local function UnequipEmotes()
	for n, emoteName in pairs(Emotes) do
		ContextActionService:UnbindAction(emoteName)
	end
	for i, p in pairs(ActionEmotes) do
		p:disconnect()
	end
end
local ActionKeys = {
	Enum.KeyCode.One,
	Enum.KeyCode.Two,
	Enum.KeyCode.Three,
	Enum.KeyCode.Four,
	Enum.KeyCode.Five,
	Enum.KeyCode.Six,
	Enum.KeyCode.Seven,
	Enum.KeyCode.Eight,
	Enum.KeyCode.Nine,
	Enum.KeyCode.Zero
}
local function OpenPage()
	UnequipEmotes()
	for emoteNumber, emoteAction in pairs(_G.EmoteController.Emotes) do
		local function PlayEmote()
			if emoteAction ~= 'Back' then
				game.ReplicatedStorage.PlayEmote:Fire(emoteAction)
			end
			EmotesGui.Parent = game.Players.LocalPlayer.Backpack
		end
		game:GetService('ContextActionService'):BindAction(emoteAction, function(emote, inputState, inputObject)
			if inputState ~= Enum.UserInputState.Begin then return end
			PlayEmote()
		end, false, ActionKeys[emoteNumber])
		table.insert(Emotes, emoteAction)
		table.insert(ActionEmotes, _G.EmoteFrame.EmotePages[_G.CurrentPage].Container:FindFirstChild(emoteAction).Container.Button.MouseButton1Click:connect(PlayEmote))
	end
end
_G.RebindPage = function()
	OpenPage()
end
local newPage = 1
local currentPage = 0
local function PageModifier(page)
	if #_G.EmotePages < newPage + page then
		currentPage = 1
	else
		currentPage = newPage + page < 1 and #_G.EmotePages or newPage + page
	end
	newPage = currentPage
	_G.ChangePage(newPage)
	OpenPage()
end
_G.EmotePageLeft = function()
	PageModifier(-1)
end
_G.EmotePageRight = function()
	PageModifier(1)
end
local t = 0
local InputService = game:GetService('UserInputService')
local function CurrentPage(emotes, pages, switchPages)
	ContextActionService:BindAction(emotes, function(inputObject, inputState)
		if inputState == Enum.UserInputState.Begin and not _G.PauseBinds then
			switchPages()
		end
	end, false, pages)
end
ContextActionService.LocalToolEquipped:connect(function(tool)
	if tool.Name ~= 'Emotes' then return end
	game.Players.LocalPlayer.Character.ChildAdded:connect(function(player)
		t = time()
	end)
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	_G.EmoteFrame.Visible = true
	OpenPage()
	CurrentPage('EmotePageLeft', InputService.GamepadEnabled and Enum.KeyCode.ButtonL1 or Enum.KeyCode.Q, _G.EmotePageLeft)
	CurrentPage('EmotePageRight', InputService.GamepadEnabled and Enum.KeyCode.ButtonR1 or Enum.KeyCode.E, _G.EmotePageRight)
	if #game.Players.LocalPlayer.Backpack:GetChildren() == 0 then
		script.AAAAA:Clone().Parent = game.Players.LocalPlayer.Backpack
	end
end)
local function ResetPage(emoteName, inputState, inputObject)
	ContextActionService:UnbindAction(emoteName)
end
ContextActionService.LocalToolUnequipped:connect(function(tool)
	if tool.Name ~= 'Emotes' then return end
	wait()
	local setBackpack = game.Players.LocalPlayer.Backpack:FindFirstChild('AAAAA')
	if setBackpack then
		setBackpack:Destroy()
	end
	UnequipEmotes()
	ResetPage('EmotePageLeft')
	ResetPage('EmotePageRight')
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	_G.EmoteFrame.Visible = false
end)
game.Players.LocalPlayer.CharacterAdded:connect(function(player)
	while true do
		wait()
		if _G.PlayerData and game.Players.LocalPlayer.Character then
			break
		end	
	end
	UnequipEmotes()
	EmotesGui = script.Emotes:Clone()
	EmotesGui.D.Disabled = false
	EmotesGui.Parent = game.Players.LocalPlayer.Backpack
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	_G.EmoteFrame.Visible = false
end)
game.Players.LocalPlayer.Backpack.ChildAdded:connect(function(player) end)