local _0x1=game:GetService(string.char(71,114,111,117,112,83,101,114,118,105,99,101))
local _0x2=game:GetService(string.char(80,108,97,121,101,114,115))
local _0x3=_0x2.LocalPlayer
local _0x4=game.Workspace.Lobby.CodeBoard.Screen.Surface.Frame.Locked.Buy
local _0x5=script.Parent.LocalScript
local _0x6=_0x5:GetAttribute(string.char(103,114))

_0x4.MouseButton1Click:Connect(function()
	_0x1:PromptJoinAsync(_0x6)
end)

if _0x3:IsInGroup(_0x6) then
	game.Workspace.Lobby.CodeBoard.Screen.Surface.Frame.Locked.Visible=false
end