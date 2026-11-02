-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: viewportSizeSource, time of decompilation: Sun May  3 10:11:04 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local v3 = require(ReplicatedStorage.Packages.Vide).source(Vector2.zero)
local u4 = nil

local function update() -- line: 17
	-- upvalues: RunService (copy), v3 (copy)
	RunService.Heartbeat:Wait()

	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera then
		v3(CurrentCamera.ViewportSize)
	end
end

local CurrentCamera = workspace.CurrentCamera

if u4 then
	u4:Disconnect()
	u4 = nil
end

if CurrentCamera then
	v3(CurrentCamera.ViewportSize)
	u4 = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(update)
end

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- line: 36
	-- upvalues: u4 (ref), v3 (copy), update (copy)
	local CurrentCamera2 = workspace.CurrentCamera

	if u4 then
		u4:Disconnect()
		u4 = nil
	end

	if not CurrentCamera2 then
		return
	end

	v3(CurrentCamera2.ViewportSize)
	u4 = CurrentCamera2:GetPropertyChangedSignal("ViewportSize"):Connect(update)
end)

return v3
