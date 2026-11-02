-- Reference copy for study. Game: Punching Simulator (punching-simulator)
-- Original: StarterPlayer/StarterPlayerScripts/Client/Modules/UI.lua
-- What it does: Central UI router: requires every child UI module, runs their _init/_start, and exposes Open/Close/Toggle by name so only one screen is open at a time (depends on the game's _L loader, Signal and Tracker classes).

--> Variables
local _L = _G._L

local Services
local Signal
local Tracker

--> Constants

------------->
local UI = {_loaded = false, _objects = {}, _current = nil}

function UI.Await()
	if not UI._loaded then
		UI.Loaded:Wait()
	end
end

function UI.Get(uiName)
	return UI._objects[uiName]
end

function UI.Open(props)
	local uiName = props.name
	local uiProps = props.props
	
	local currentUiName = UI._current:Get()
	
	if currentUiName then
		UI.Close({name = currentUiName}, true)
	end
	
	if uiName then
		local ui = UI.Get(uiName)
		
		UI._current:Set(uiName)
		ui.is_open:Set(true, {
			props = props.props
		})
	end
end

function UI.Close(props, dont)
	local uiName = props.name
	local uiProps = props.props
	
	local currentUiName = UI._current:Get()
	
	if uiName and uiName == currentUiName then
		local ui = UI.Get(uiName)
		
		if not dont then
			UI._current:Set(nil)
		end
		
		ui.is_open:Set(false, {
			props = props.props
		})
	end
end

function UI.Toggle(props)
	local uiName = props.name
	
	local ui = UI.Get(uiName)
	
	local uiState = props.state or ui.is_open:Get()
	
	if uiState then
		UI.Close(props)
	else
		UI.Open(props)
	end
end

function UI.GetLast()
	return UI._current:GetLast()
end

function UI._init()
	Services = _L.Get {"Common", "Library", "Services"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	
	UI.Loaded = Signal.new()
	UI._current = Tracker.new(nil)
end

function UI._start()
	_L.Storage:WaitForChild("UI")
	
	for _, instance in pairs(_L.Storage.UI:GetChildren()) do
		instance.Parent = _L.PlayerGui
	end
	
	for _, uiModule in pairs(script:GetChildren()) do
		if uiModule:IsA("ModuleScript") then
			local ui = require(uiModule)
			local uiName = ui.name
			
			UI._objects[uiName] = ui
		end
	end
	
	for uiName, ui in pairs(UI._objects) do
		if typeof(ui) == "table" and typeof(rawget(ui, "_init")) == "function" then
			ui:_init()
			print("[UI] => ["..uiName.."]: *initialized*")
		end
	end

	for uiName, ui in pairs(UI._objects) do
		if typeof(ui) == "table" and typeof(rawget(ui, "_start")) == "function" then
			task.spawn(function()
				ui:_start()
			end)
		end
	end
	
	UI._loaded = true
	UI.Loaded:Fire()
end

return UI