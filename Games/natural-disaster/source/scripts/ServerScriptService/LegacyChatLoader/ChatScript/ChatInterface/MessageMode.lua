-- // Tracks the current message mode.

local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local MessageMode = {}

local messageMode: string? = nil

export type messageModePropertiesType = {
	commandName: string,
	name: string,
	displayText: string,
	color: Color3,
	
	metadata: string?,
}
local messageModeProperties: messageModePropertiesType? = nil

local messageModeChangedBindable = Instance.new("BindableEvent")
messageModeChangedBindable.Name = "MessageModeChangedBindable"

function MessageMode.get()
	return messageModeProperties
end

function MessageMode.getBindable()
	return messageModeChangedBindable
end

function MessageMode.set(newMessageModeProperties: messageModePropertiesType?)
	if newMessageModeProperties == nil then
		if messageModeProperties == nil then
			return
		end
	else
		if messageModeProperties ~= nil and newMessageModeProperties.name == messageModeProperties.name then
			return
		end
	end
	
	ChatUtil.debugPrint(`Message mode set to {tostring(newMessageModeProperties and newMessageModeProperties.name)}`)
	
	messageMode = newMessageModeProperties and newMessageModeProperties.name
	messageModeProperties = newMessageModeProperties
	
	messageModeChangedBindable:Fire(newMessageModeProperties)
end

return MessageMode