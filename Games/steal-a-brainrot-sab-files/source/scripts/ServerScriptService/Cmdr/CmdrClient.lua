local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Shared = script:WaitForChild("Shared")
local Util = require(Shared:WaitForChild("Util"))

if RunService:IsClient() == false then
	error("Server scripts cannot require the client library. Please require the server library to use Cmdr in your own code.")
end

local Cmdr do
	Cmdr = setmetatable({
		ReplicatedRoot = script;
		RemoteFunction = script:WaitForChild("CmdrFunction");
		RemoteEvent = script:WaitForChild("CmdrEvent");
		ActivationKeys = {[Enum.KeyCode.F4] = true};
		Enabled = true;
		MashToEnable = false;
		ActivationUnlocksMouse = false;
		HideOnLostFocus = true;
		PlaceName = "Cmdr";
		Util = Util;
		Events = {};
	}, {
		__index = function (self, k)
			local r = self.Dispatcher[k]
			if r and type(r) == "function" then
				return function (_, ...)
					return r(self.Dispatcher, ...)
				end
			end
		end
	})

	Cmdr.Registry = require(Shared.Registry)(Cmdr)
	Cmdr.Dispatcher = require(Shared.Dispatcher)(Cmdr)
end

if StarterGui:WaitForChild("Cmdr") and wait() and Player:WaitForChild("PlayerGui"):FindFirstChild("Cmdr") == nil then
	StarterGui.Cmdr:Clone().Parent = Player.PlayerGui
end

local Interface = require(script.CmdrInterface)(Cmdr)

function Cmdr:SetActivationKeys (keysArray)
	self.ActivationKeys = Util.MakeDictionary(keysArray)
end

function Cmdr:SetPlaceName (name)
	self.PlaceName = name
	Interface.Window:UpdateLabel()
end

function Cmdr:SetEnabled (enabled)
	self.Enabled = enabled
end

function Cmdr:SetActivationUnlocksMouse (enabled)
	self.ActivationUnlocksMouse = enabled
end

function Cmdr:Show ()
	if not self.Enabled then
		return
	end

	Interface.Window:Show()
end

function Cmdr:Hide ()
	Interface.Window:Hide()
end

function Cmdr:Toggle ()
	if not self.Enabled then
		return self:Hide()
	end

	Interface.Window:SetVisible(not Interface.Window:IsVisible())
end

function Cmdr:SetMashToEnable(isEnabled)
	self.MashToEnable = isEnabled

	if isEnabled then
		self:SetEnabled(false)
	end
end

function Cmdr:SetHideOnLostFocus(enabled)
	self.HideOnLostFocus = enabled
end

function Cmdr:HandleEvent(name, callback)
	self.Events[name] = callback
end

if RunService:IsServer() == false then
	Cmdr.Registry:RegisterTypesIn(script:WaitForChild("Types"))
	Cmdr.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
end

Cmdr.RemoteEvent.OnClientEvent:Connect(function(name, ...)
	if Cmdr.Events[name] then
		Cmdr.Events[name](...)
	end
end)

require(script.DefaultEventHandlers)(Cmdr)

return Cmdr
