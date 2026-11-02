--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMsCXdvcmtzcGFjZRBEZWJ1Z01vZGVFbmFibGVkDEdldEF0dHJpYnV0ZQVwcmludApkZWJ1Z1ByaW50BHR5cGUIZnVuY3Rpb24FcGNhbGwEd2FybiFbTG9jYWxMZXZlbEV2ZW50c10gQ2xlYW51cCBlcnJvcjoSY2xlYW51cExvY2FsRXZlbnRzDmxvY2FsQmVoYXZpb3JzBlBhcmVudCJbTG9jYWxMZXZlbEV2ZW50c10gUmVjZWl2ZWQgZXZlbnQ6CmZvciBsZXZlbDoRRXhlY3V0ZUxvY2FsRXZlbnQzW0xvY2FsTGV2ZWxFdmVudHNdIE5vIGV2ZW50IGNvbmZpZyBmb3VuZCBmb3IgbGV2ZWw6LltMb2NhbExldmVsRXZlbnRzXSBFeGVjdXRpbmcgbG9jYWwgZXZlbnRzIGZvcjoPQW5jZXN0cnlDaGFuZ2VkB0Nvbm5lY3QzW0xvY2FsTGV2ZWxFdmVudHNdIEVycm9yIGV4ZWN1dGluZyBsb2NhbCBiZWhhdmlvcnM6EUNsZWFudXBMb2NhbEV2ZW50BGdhbWUHUGxheWVycwtMb2NhbFBsYXllcgVwYWlycxFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClJ1blNlcnZpY2UZR2V0QXR0cmlidXRlQ2hhbmdlZFNpZ25hbBdTcGVjaWFsTGV2ZWxFdmVudFJlbW90ZQxXYWl0Rm9yQ2hpbGRFW0xvY2FsTGV2ZWxFdmVudHNdIFNwZWNpYWxMZXZlbEV2ZW50UmVtb3RlIG5vdCBmb3VuZCBhZnRlciAzMCBzZWNvbmRzC0xldmVsRXZlbnRzC0dldENoaWxkcmVuDE1vZHVsZVNjcmlwdANJc0EHcmVxdWlyZQROYW1lBkV2ZW50JAAEZ3N1YitbTG9jYWxMZXZlbEV2ZW50c10gTG9hZGVkIGxvY2FsIGV2ZW50cyBmb3I6DU9uQ2xpZW50RXZlbnQACQMAAQAAAA+kAAEAAAAAQG8CAgC8AAASAwAAAJ8AAwIOAAcApAABAAAAAEBvAgIAvAAAEgMAAACfAAMC3gAAAIIAAQAEAwEEAAAAQAMCAwMADAABGAAAAAAAAAABAAAAAAAAAg0AAAAAAgABAQAACKMAAAD7AAAADgAEAKQAAQAAAABA3QEAAJ8AAAGCAAEAAgMEBAAAAEAA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

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local v1 = false

pcall(function() --[[ Line: 12 | Upvalues: v1 (ref) ]]
	if not workspace:GetAttribute("DebugModeEnabled") then
		return
	end

	v1 = workspace:GetAttribute("DebugModeEnabled")
end)

local function debugPrint(...) --[[ debugPrint | Line: 19 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	print(...)
end

workspace:GetAttributeChangedSignal("DebugModeEnabled"):Connect(function() --[[ Line: 26 | Upvalues: v1 (ref) ]]
	v1 = workspace:GetAttribute("DebugModeEnabled") or false
end)

local SpecialLevelEventRemote = ReplicatedStorage:WaitForChild("SpecialLevelEventRemote", 30)

if not SpecialLevelEventRemote then
	warn("[LocalLevelEvents] SpecialLevelEventRemote not found after 30 seconds")

	return
end

local t = {}
local t2 = {}
local LevelEvents = ReplicatedStorage:WaitForChild("LevelEvents", 5)

if LevelEvents then
	for k, v in pairs(LevelEvents:GetChildren()) do
		if v:IsA("ModuleScript") then
			local ok, result = pcall(require, v)

			if ok and result.localBehaviors then
				local v2 = v.Name:gsub("Event$", "")

				t2[v2] = result
				debugPrint("[LocalLevelEvents] Loaded local events for:", v2)
			end
		end
	end
end

local function cleanupLocalEvents(p1) --[[ cleanupLocalEvents | Line: 58 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	if type(v1) == "function" then
		local ok, result = pcall(v1)

		if not ok then
			warn("[LocalLevelEvents] Cleanup error:", result)
		end
	end

	t[p1] = nil
end

SpecialLevelEventRemote.OnClientEvent:Connect(function(p1, p2, p3, p4) --[[ Line: 72 | Upvalues: t2 (copy), t (copy) ]]
	print("[LocalLevelEvents] Received event:", p1, "for level:", p2)

	if p1 == "ExecuteLocalEvent" then
		local v1 = t2[p2]

		if not v1 then
			warn("[LocalLevelEvents] No event config found for level:", p2)

			return
		end

		print("[LocalLevelEvents] Executing local events for:", p2)

		local v2 = t[p3]

		if v2 then
			if type(v2) == "function" then
				local ok, result = pcall(v2)

				if not ok then
					warn("[LocalLevelEvents] Cleanup error:", result)
				end
			end

			t[p3] = nil
		end

		if not v1.localBehaviors then
			return
		end

		local ok, result = pcall(function() --[[ Line: 88 | Upvalues: v1 (copy), p3 (copy), p4 (copy) ]]
			return v1.localBehaviors(p3, p4)
		end)

		if ok and result then
			t[p3] = result
			p3.AncestryChanged:Connect(function() --[[ Line: 97 | Upvalues: p3 (copy), t (ref) ]]
				if p3.Parent then
					return
				end

				local v1 = p3
				local v2 = t[v1]

				if not v2 then
					return
				end

				if type(v2) == "function" then
					local ok, result = pcall(v2)

					if not ok then
						warn("[LocalLevelEvents] Cleanup error:", result)
					end
				end

				t[v1] = nil
			end)

			return
		end

		if not ok then
			warn("[LocalLevelEvents] Error executing local behaviors:", result)
		end
	else
		if p1 ~= "CleanupLocalEvent" then
			return
		end

		local v3 = t[p3]

		if not v3 then
			return
		end

		if type(v3) == "function" then
			local ok, result = pcall(v3)

			if not ok then
				warn("[LocalLevelEvents] Cleanup error:", result)
			end
		end

		t[p3] = nil
	end
end)
game.Players.LocalPlayer.AncestryChanged:Connect(function() --[[ Line: 113 | Upvalues: t (copy) ]]
	if game.Players.LocalPlayer.Parent then
		return
	end

	for k, v in pairs(t) do
		local v1 = t[k]

		if v1 then
			if type(v1) == "function" then
				local ok, result = pcall(v1)

				if not ok then
					warn("[LocalLevelEvents] Cleanup error:", result)
				end
			end

			t[k] = nil
		end
	end
end)