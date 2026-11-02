-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local Classes = ReplicatedStorage:WaitForChild("Classes")

local InteractController = require(Controllers.InteractController)
local InterfaceClass = require(Classes.Interface)
local Styles = require(Classes.Interface.Styles)

local ToggleRemote = script.Toggle

local RegisteredInterfaces = {}
local InterfaceManager = {}

function InterfaceManager:SetState(interfaceName, shouldBeOpen, ignoreList)
	local interface = RegisteredInterfaces[interfaceName]

	if not interface then
		return
	end

	if interface:IsOpened() == shouldBeOpen then
		return
	else
		self:Toggle(interfaceName, shouldBeOpen, ignoreList)
	end
end

function InterfaceManager:Toggle(interfaceName, forcedState, ignoreList)
	local targetInterface = RegisteredInterfaces[interfaceName]

	if not targetInterface then
		return
	end

	local newState = (forcedState ~= nil) and forcedState or not targetInterface:IsOpened()
	local hudShouldShow = true

	for name, interface in pairs(RegisteredInterfaces) do
		if name == interfaceName then
			interface:Toggle(newState)

			if interface:IsOpened() == false then
				hudShouldShow = false
			end
		elseif interface:IsOpened() then
			if ignoreList then
				if not table.find(ignoreList, name) then
					interface:Close()
				end
			else
				interface:Close()
			end
		end
	end

	if hudShouldShow == false and RegisteredInterfaces.Hud then
		RegisteredInterfaces.Hud:Toggle(true)
	end
end

function InterfaceManager:GetInterfaces()
	return RegisteredInterfaces
end

function InterfaceManager:Get(interfaceName)
	return RegisteredInterfaces[interfaceName]
end

function InterfaceManager:Register(interfaceName, data, settings)
	if RegisteredInterfaces[interfaceName] then
		warn(("Failed to create interface: %s, already exists!"):format(interfaceName))
	else
		RegisteredInterfaces[interfaceName] = InterfaceClass.new(interfaceName, data, settings)
		return RegisteredInterfaces[interfaceName]
	end
end

function InterfaceManager:Start()
	ToggleRemote.Event:Connect(function(...)
		self:Toggle(...)
	end)

	InteractController.OnInteractEnter:Connect(function(object)
		if object:GetAttribute("Interface") ~= true then
			return
		end

		local interface = RegisteredInterfaces[object.Name]
		if interface and not interface:IsOpened() then
			self:Toggle(object.Name, true)
		end
	end)

	InteractController.OnInteractLeave:Connect(function(object)
		if object:GetAttribute("Interface") ~= true then
			return
		end

		local interface = RegisteredInterfaces[object.Name]
		if interface and interface:IsOpened() then
			self:Toggle(object.Name, false)
		end
	end)
end

return InterfaceManager