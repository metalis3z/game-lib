local Radioactive = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local isactive = nil
local ATTRIBUTE_NAME = "RadioactiveEvent"

ReplicatedStorage:SetAttribute(ATTRIBUTE_NAME, nil)

function Radioactive.OnStart()
	if isactive then return end
	isactive = true
	ReplicatedStorage:SetAttribute(ATTRIBUTE_NAME, true)
end

function Radioactive.OnStop()
	if isactive == nil then return end
	isactive = nil
	ReplicatedStorage:SetAttribute(ATTRIBUTE_NAME, nil)
end

ReplicatedStorage:GetAttributeChangedSignal(ATTRIBUTE_NAME):Connect(function()
	local currentAttr = ReplicatedStorage:GetAttribute(ATTRIBUTE_NAME)

	if currentAttr ~= isactive then
		ReplicatedStorage:SetAttribute(ATTRIBUTE_NAME, isactive)
	end
end)

return Radioactive