if not game:IsLoaded() then
	game.Loaded:Wait()
end

local LocalPlayer = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local function isTouch() --[[ isTouch | Line: 8 | Upvalues: UserInputService (copy) ]]
	local isTouch = UserInputService:GetLastInputType() == Enum.UserInputType.Touch

	return isTouch
end

local v1 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local core = require(script.core)

LocalPlayer.CameraMaxZoomDistance = 20
pcall(function() --[[ Line: 17 | Upvalues: v1 (copy) ]]
	if not v1 then
		return
	end

	print("is touch")
end)
PlayerGui:SetTopbarTransparency(1)

local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

Lib.Inject("dHandler", LocalPlayer.PlayerScripts:WaitForChild("LocalDataHandler"))
Lib.Inject("DS", require(Lib.dHandler))
Lib.Inject("data", Lib.DS.RequestData())
Lib.Inject("IsTouch", v1)

local GuiService = game:GetService("GuiService")

Lib.Inject("IsConsole", GuiService:IsTenFootInterface())
Lib.dHandler.UpdateData.Event:connect(function(p1) --[[ Line: 37 | Upvalues: Lib (copy) ]]
	Lib.Inject("data", Lib.DS.RequestData())
end)
Lib.Network:FireServer("Touch", v1)
game:GetService("RunService"):IsStudio()
game:GetService("Chat"):RegisterChatCallback(Enum.ChatCallbackType.OnCreatingChatWindow, function() --[[ Line: 48 ]]
	return {
		BubbleChatEnabled = true
	}
end)
core.Call("SetCore", "ResetButtonCallback", false)
core.Call("SetCoreGuiEnabled", Enum.CoreGuiType.PlayerList, false)

local v2 = LocalPlayer:GetMouse()

if v2 and not (v1 or Lib.IsConsole) then
	v2.Icon = "http://www.roblox.com/asset/?id=11514440775"
end

-- print("\240\159\145\187\240\159\145\187\240\159\145\187\240\159\145\187\240\159\145\187\240\159\145\187 GAME VERSION", game.PlaceVersion, "GAME VERSION \240\159\145\187\240\159\145\187\240\159\145\187\240\159\145\187\240\159\145\187\240\159\145\187")

local v3 = next
local v4, v5 = script.Parent:WaitForChild("UI"):GetChildren()

for v6, v7 in v3, v4, v5 do
	if v7:IsA("ModuleScript") then
		task.spawn(function() --[[ Line: 72 | Upvalues: v7 (copy) ]]
			return require(v7)
		end)
	end
end

Lib.Inject("UserUsingController", function() --[[ Line: 78 ]]
	if game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Gamepad1 then
		return true
	end
end)
task.spawn(Lib.Talk.LoadTranslator)

if v1 then
	return
end

Lib.RS:IsStudio()