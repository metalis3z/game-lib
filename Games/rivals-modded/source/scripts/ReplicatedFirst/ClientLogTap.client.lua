-- Client half of ServerScriptService.Server.LogTap: the Output lines worth reading, without
-- the flood of asset-permission warnings, kept in the LocalPlayer's "Log" attribute.

local LogService = game:GetService("LogService")
local Players = game:GetService("Players")

local MAX_LINES = 400
local MAX_LENGTH = 240
local NOISE = {
	"not authorized",
	"permiso de acceso",
	"Failed to load",
	"Cloud instance",
	"Missing description",
	"SSAI",
	"GuiInspector",
}

local player = Players.LocalPlayer
local lines: { string } = {}

local function isNoise(message: string): boolean
	for _, pattern in NOISE do
		if string.find(message, pattern, 1, true) then
			return true
		end
	end
	return false
end

LogService.MessageOut:Connect(function(message: string, messageType: Enum.MessageType)
	if isNoise(message) then
		return
	end

	table.insert(lines, string.format("[%s] %s", string.sub(messageType.Name, 8), string.sub(message, 1, MAX_LENGTH)))
	while #lines > MAX_LINES do
		table.remove(lines, 1)
	end

	player:SetAttribute("Log", table.concat(lines, "\n"))
end)
