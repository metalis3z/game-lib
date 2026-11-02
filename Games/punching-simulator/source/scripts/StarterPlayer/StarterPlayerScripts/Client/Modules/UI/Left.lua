--> Variables
local _L = _G._L

local Services
local Signal
local Tracker
local Data
local TableUtility
local NumberUtility
local Spr
local Trove
local Audio
local Shared
local Timer
local FastTween
local cancellableDelay
local Constants
local AttributeUtility
local TrackerUtility

--> Constants

------------->
local Left = {
	name = script.Name
}

function Left:_init()
	Services = _L.Get {"Common", "Library", "Services"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	Timer = _L.Get {"Common", "Library", "Classes", "Timer"}
	Data = _L.Get {"Client", "Library", "Classes", "Data"}
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	NumberUtility = _L.Get {"Common", "Library", "Utilities", "NumberUtility"}
	TrackerUtility = _L.Get {"Common", "Library", "Utilities", "TrackerUtility"}
	AttributeUtility = _L.Get {"Common", "Library", "Utilities", "AttributeUtility"}
	Spr = _L.Get {"Common", "Library", "Physics", "Spr"}
	Trove = _L.Get {"Common", "Library", "Classes", "Trove"}
	Audio = _L.Get {"Common", "Library", "Audio"} 
	Shared = _L.Get {"Common", "Modules", "Shared"}
	FastTween = _L.Get {"Common", "Library", "Functions", "FastTween"}
	cancellableDelay = _L.Get {"Common", "Library", "Functions", "cancellableDelay"}
	Constants = _L.Get {"Common", "Modules", "Constants"}
	UI = _L.Get {"Client", "Modules", "UI"}
end

function Left:_start()
	self.object = _L.PlayerGui.Main.Left
	
	local data = Data.Await()

	if data then
		local og = self.object.Position
		
		--Tracker.Subscribe({UI._current, data:Track("tutorial_marker")}, function()
		--	local s = UI._current:Get()
		--	local t = data:Get("tutorial_marker")
		--	self.object.Visible = if s then false else true
		--	Spr.Target(self.object, 0.9, 3, {
		--		Position = UDim2.fromScale(og.X.Scale - if s or t < 3 then 1 else 0, og.Y.Scale)
		--	})
		--end)
	end
	
	local newExperienceInviteOptions = Instance.new("ExperienceInviteOptions")
	
	newExperienceInviteOptions.PromptMessage = "Earn x0.5 boost per friend invited!"
	
	self.object.Content.Invite.MouseButton1Down:Connect(function()
		Services.SocialService:PromptGameInvite(_L.Player, newExperienceInviteOptions)
	end)
end

return Left