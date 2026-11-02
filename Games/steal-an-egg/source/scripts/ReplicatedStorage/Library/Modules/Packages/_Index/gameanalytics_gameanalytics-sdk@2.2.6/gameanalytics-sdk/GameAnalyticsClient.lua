-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScriptContext = game:GetService("ScriptContext")

function t.initClient() --[[ initClient | Line: 15 | Upvalues: ScriptContext (copy), ReplicatedStorage (copy), GuiService (copy), UserInputService (copy) ]]
	local Postie = require(script.Parent.GameAnalytics.Postie)

	ScriptContext.Error:Connect(function(p1, p2, p3) --[[ Line: 18 | Upvalues: ReplicatedStorage (ref) ]]
		if not p3 then
			return
		end

		local v1 = nil
		local ok, _ = pcall(function() --[[ Line: 24 | Upvalues: v1 (ref), p3 (copy) ]]
			v1 = p3:GetFullName()
		end)

		if ok then
			ReplicatedStorage.GameAnalyticsError:FireServer(p1, p2, v1)
		end
	end)

	local function getPlatform() --[[ getPlatform | Line: 35 | Upvalues: GuiService (ref), UserInputService (ref) ]]
		if GuiService:IsTenFootInterface() then
			return "Console"
		end

		if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
			return "Mobile"
		end

		return "Desktop"
	end

	Postie.setCallback("getPlatform", getPlatform)
end

return t