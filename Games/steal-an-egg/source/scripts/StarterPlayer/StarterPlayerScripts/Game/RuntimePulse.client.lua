-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Network = require(ReplicatedStorage.Library.Client.Network)
local t = {
	"dex",
	"dex explorer",
	"remote spy",
	"hydroxide",
	"dark dex",
	"simple spy",
	"owl hub",
	"rayfield",
	"infinite yield"
}
local RuntimeSync = Constants.NETWORK_MAP.RuntimeSync
local v1 = nil
local v2 = 0
local t2 = {}

local function concealScriptIdentity() --[[ concealScriptIdentity | Line: 50 | Upvalues: HttpService (copy) ]]
	script.Name = string.format("Runtime_%s", (string.sub(HttpService:GenerateGUID(false), 1, 8)))
end

local function report(p1, p2) --[[ report | Line: 55 | Upvalues: Network (copy), RuntimeSync (copy) ]]
	Network.Fire(RuntimeSync.REPORT, p1, if p2 then p2 else {})
end

local function sendHeartbeat() --[[ sendHeartbeat | Line: 59 | Upvalues: v1 (ref), v2 (ref), Network (copy), RuntimeSync (copy) ]]
	local v12 = v1

	if v12 then
		v2 = v2 + 1
		Network.Fire(RuntimeSync.HEARTBEAT, {
			challengeId = v12.challengeId,
			nonce = v12.nonce,
			sequence = v2
		})
	end
end

local function scanCoreGui() --[[ scanCoreGui | Line: 73 | Upvalues: CoreGui (copy), t (copy), t2 (copy), Network (copy), RuntimeSync (copy) ]]
	local ok, result = pcall(function() --[[ Line: 74 | Upvalues: CoreGui (ref) ]]
		return CoreGui:GetChildren()
	end)

	if not ok then
		return
	end

	for i, v in ipairs(result) do
		local v1 = string.lower(v.Name)

		for i2, v2 in ipairs(t) do
			if string.find(v1, v2, 1, true) and not t2[v1] then
				t2[v1] = true

				local t3 = {
					name = v.Name,
					className = v.ClassName
				}

				Network.Fire(RuntimeSync.REPORT, "CoreGuiHeuristic", if t3 then t3 else {})

				break
			end
		end
	end
end

script.Name = string.format("Runtime_%s", (string.sub(HttpService:GenerateGUID(false), 1, 8)))
Network.Fired(RuntimeSync.CHALLENGE):Connect(function(p1) --[[ Line: 98 | Upvalues: v1 (ref) ]]
	v1 = p1
end)
script:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 102 | Upvalues: Network (copy), RuntimeSync (copy) ]]
	if script.Enabled then
		return
	end

	local t = {
		reason = "DetectorDisabled",
		severity = 2
	}

	Network.Fire(RuntimeSync.REPORT, "Tamper", if t then t else {})
end)
script.Destroying:Connect(function() --[[ Line: 111 | Upvalues: Network (copy), RuntimeSync (copy) ]]
	local t = {
		reason = "DetectorDestroying",
		severity = 2
	}

	Network.Fire(RuntimeSync.REPORT, "Tamper", if t then t else {})
end)
task.spawn(function() --[[ Line: 118 | Upvalues: v1 (ref), v2 (ref), Network (copy), RuntimeSync (copy), scanCoreGui (copy) ]]
	repeat
		local v12 = v1

		if v12 then
			v2 = v2 + 1
			Network.Fire(RuntimeSync.HEARTBEAT, {
				challengeId = v12.challengeId,
				nonce = v12.nonce,
				sequence = v2
			})
		end

		scanCoreGui()

		local v22 = 4

		if v1 and type(v1.heartbeatInterval) == "number" then
			v22 = math.max(2, v1.heartbeatInterval)
		end

		task.wait(v22)
	until not v12
end)