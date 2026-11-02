--> Variables
local _L = _G._L

local Services
local Signal
local Tracker
local Trove
local Spr
local Audio

--> Constants

------------->
local PopButton = {}
PopButton.__index = PopButton

function PopButton.new(instance)
	local self = setmetatable({}, PopButton)
	
	self._instance = instance
	
	self._ui_scale = nil
	
	self._trove = Trove.new()
	
	self:_construct()
	
	return self
end

function PopButton:_construct()
	self._ui_scale = self._instance:FindFirstChild("UIScale") or Create("UIScale", {
		Parent = self._instance
	})
	
	local factor = self._ui_scale.Scale
	
	self._trove:Connect(self._instance.MouseButton1Down, function()
		Spr.Target(self._ui_scale, 1, 15, {
			Scale = 0.925 * factor
		})
		
		Audio.Play {name = "ButtonDown1"}
	end)
	
	self._trove:Connect(self._instance.MouseButton1Up, function()
		Spr.Target(self._ui_scale, 1, 15, {
			Scale = 1 * factor
		})
	end)
	
	self._trove:Connect(self._instance.MouseEnter, function()
		Spr.Target(self._ui_scale, 1, 15, {
			Scale = 1.075 * factor
		})
	end)
	
	self._trove:Connect(self._instance.MouseLeave, function()
		Spr.Target(self._ui_scale, 1, 15, {
			Scale = 1 * factor
		})
	end)
end

function PopButton:Destroy()
	self._trove:Destroy()
end

function PopButton._init()
	Services = _L.Get {"Common", "Library", "Services"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	Trove = _L.Get {"Common", "Library", "Classes", "Trove"}
	Spr = _L.Get {"Common", "Library", "Physics", "Spr"}
	Create = _L.Get {"Common", "Library", "Functions", "Create"}
	Audio = _L.Get {"Common", "Library", "Audio"} 
end

function PopButton._start()
end

return PopButton