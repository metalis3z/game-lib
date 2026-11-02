-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")

local v1 = script.Parent
local Run = v1.Parent:FindFirstChild("Run")
local Stop = v1.Parent:FindFirstChild("Stop")
local Select = v1.Parent:FindFirstChild("Select")
local AdminPanel = script:FindFirstAncestor("AdminPanel")
local v2 = if AdminPanel then AdminPanel.Parent else AdminPanel
local v3 = v2 and v2:FindFirstChild("AdminSelection")
local AdminCooldownClient = require(AdminPanel:WaitForChild("AdminCooldownClient"))
local StartEventRemote = ReplicatedStorage:WaitForChild("StartEventRemote")
local StopEventRemote = ReplicatedStorage:WaitForChild("StopEventRemote")
local ok, result = pcall(function() --[[ Line: 29 | Upvalues: ReplicatedStorage (copy) ]]
	return require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Data"):WaitForChild("WeatherData"))
end)

local function norm(p1) --[[ norm | Line: 41 ]]
	return p1:lower():gsub("[%s%-_]", "")
end

local t = {}

for i, v in ipairs(ok and result and result.ValidEvents or {
	"Stadium",
	"Disco",
	"Void",
	"Virus",
	"Wet",
	"Alien",
	"Bacon",
	"Enchanted",
	"Phantom",
	"Fire",
	"VolcanoEvent"
}) do
	t[v:lower():gsub("[%s%-_]", "")] = v
end

local function resolveEventName(p1) --[[ resolveEventName | Line: 49 | Upvalues: t (copy) ]]
	if p1 == "" then
		return nil
	end

	return t[p1:lower():gsub("[%s%-_]", "")]
end

local v5 = nil

local function showNotif(p1, p2) --[[ showNotif | Line: 56 | Upvalues: v5 (ref) ]]
	if not v5 then
		local AdminPanel = script:FindFirstAncestor("AdminPanel")
		local v1 = if AdminPanel then AdminPanel:FindFirstChild("NotifModule") else AdminPanel

		if v1 then
			local ok, result = pcall(require, v1)

			if ok then
				v5 = result
			end
		end
	end

	if not v5 then
		return
	end

	v5(p1, p2 ~= false)
end

if Select and (v3 and AdminPanel) then
	Select.MouseButton1Click:Connect(function() --[[ Line: 66 | Upvalues: v3 (copy), AdminPanel (copy) ]]
		v3:SetAttribute("Mode", "EventRunner")
		AdminPanel.Visible = false
		v3.Visible = true
	end)
end

if Run then
	Run.MouseButton1Click:Connect(function() --[[ Line: 74 | Upvalues: v1 (copy), t (copy), showNotif (copy), AdminCooldownClient (copy), StartEventRemote (copy) ]]
		local Text = v1.Text
		local v12 = if Text == "" then nil else t[Text:lower():gsub("[%s%-_]", "")]

		if not v12 then
			showNotif("Unknown event: " .. v1.Text, false)

			return
		end

		if AdminCooldownClient:Try("EventRunner") then
			StartEventRemote:FireServer(v12)
			showNotif("Event started: " .. v12, true)
		end
	end)
end

if not Stop then
	return
end

Stop.MouseButton1Click:Connect(function() --[[ Line: 87 | Upvalues: v1 (copy), t (copy), AdminCooldownClient (copy), StopEventRemote (copy), showNotif (copy) ]]
	local Text = v1.Text
	local v12 = if Text == "" then nil else t[Text:lower():gsub("[%s%-_]", "")]

	if not AdminCooldownClient:Try("EventRunner") then
		return
	end

	StopEventRemote:FireServer(v12)
	showNotif(if v12 then "Event stopped: " .. v12 or "Event stopped" else "Event stopped", true)
end)