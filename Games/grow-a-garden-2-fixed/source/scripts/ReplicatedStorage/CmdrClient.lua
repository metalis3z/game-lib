--credit to leon games studio
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Shared = script:WaitForChild("Shared")
local Util = require(Shared:WaitForChild("Util"))

if RunService:IsClient() == false then
	error("Server scripts cannot require the client library. Please require the server library to use Cmdr in your own code.")
end

local v1 = setmetatable({
	Enabled = true,
	MashToEnable = false,
	ActivationUnlocksMouse = false,
	HideOnLostFocus = true,
	PlaceName = "Cmdr",
	ReplicatedRoot = script,
	RemoteFunction = script:WaitForChild("CmdrFunction"),
	RemoteEvent = script:WaitForChild("CmdrEvent"),
	ActivationKeys = {
		[Enum.KeyCode.F2] = true
	},
	Util = Util,
	Events = {}
}, {
	__index = function(p1, p2) --[[ __index | Line: 28 ]]
		local v1 = p1.Dispatcher[p2]

		if v1 and type(v1) == "function" then
			return function(p12, ...) --[[ Line: 31 | Upvalues: v1 (copy), p1 (copy) ]]
				return v1(p1.Dispatcher, ...)
			end
		end
	end
})

v1.Registry = require(Shared.Registry)(v1)
v1.Dispatcher = require(Shared.Dispatcher)(v1)

if StarterGui:WaitForChild("Cmdr") and (wait() and LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Cmdr") == nil) then
	StarterGui.Cmdr:Clone().Parent = LocalPlayer.PlayerGui
end

local v2 = require(script.CmdrInterface)(v1)

function v1.SetActivationKeys(p1, p2) --[[ SetActivationKeys | Line: 49 | Upvalues: Util (copy) ]]
	p1.ActivationKeys = Util.MakeDictionary(p2)
end
function v1.SetPlaceName(p1, p2) --[[ SetPlaceName | Line: 54 | Upvalues: v2 (copy) ]]
	p1.PlaceName = p2
	v2.Window:UpdateLabel()
end
function v1.SetEnabled(p1, p2) --[[ SetEnabled | Line: 60 ]]
	p1.Enabled = p2
end
function v1.SetActivationUnlocksMouse(p1, p2) --[[ SetActivationUnlocksMouse | Line: 65 ]]
	p1.ActivationUnlocksMouse = p2
end
function v1.Show(p1) --[[ Show | Line: 70 | Upvalues: v2 (copy) ]]
	if p1.Enabled then
		v2.Window:Show()
	end
end
function v1.Hide(p1) --[[ Hide | Line: 79 | Upvalues: v2 (copy) ]]
	v2.Window:Hide()
end
function v1.Toggle(p1) --[[ Toggle | Line: 84 | Upvalues: v2 (copy) ]]
	if p1.Enabled then
		v2.Window:SetVisible(not v2.Window:IsVisible())

		return
	end

	return p1:Hide()
end
function v1.SetMashToEnable(p1, p2) --[[ SetMashToEnable | Line: 93 ]]
	p1.MashToEnable = p2

	if not p2 then
		return
	end

	p1:SetEnabled(false)
end
function v1.SetHideOnLostFocus(p1, p2) --[[ SetHideOnLostFocus | Line: 102 ]]
	p1.HideOnLostFocus = p2
end
function v1.HandleEvent(p1, p2, p3) --[[ HandleEvent | Line: 107 ]]
	p1.Events[p2] = p3
end

if RunService:IsServer() == false then
	v1.Registry:RegisterTypesIn(script:WaitForChild("Types"))
	v1.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
end

v1.RemoteEvent.OnClientEvent:Connect(function(p1, ...) --[[ Line: 118 | Upvalues: v1 (ref) ]]
	if not v1.Events[p1] then
		return
	end

	v1.Events[p1](...)
end)
require(script.DefaultEventHandlers)(v1)

return v1