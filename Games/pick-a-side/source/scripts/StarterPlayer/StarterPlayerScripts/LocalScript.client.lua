-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:52
-- Luau version 6, Types version 3
-- Time taken: 0.002785 seconds

local module = require(game:GetService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"))
module.BubbleChatEnabled = true
module.ClassicChatEnabled = false
game.Players.LocalPlayer.CharacterAdded:Connect(function(arg1) -- Line 10
	local Humanoid = arg1:WaitForChild("Humanoid")
	for _, v in pairs({"Climbing", "PlatformStanding", "Ragdoll", "Swimming"}) do
		Humanoid:SetStateEnabled(Enum.HumanoidStateType[v], false)
	end
end)
local Signals_upvr = game.ReplicatedStorage.Signals
game:GetService("ScriptContext").Error:Connect(function(arg1, ...) -- Line 22
	--[[ Upvalues[1]:
		[1]: Signals_upvr (readonly)
	]]
	Signals_upvr.LogError:FireServer(arg1, ...)
end)
local Players_upvr = game.Players
game:GetService("TextChatService").OnIncomingMessage = function(arg1) -- Line 31
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	local TextChatMessageProperties = Instance.new("TextChatMessageProperties")
	local TextSource = arg1.TextSource
	if TextSource then
		if Players_upvr:GetPlayerByUserId(TextSource.UserId):GetAttribute("VIP") then
			TextChatMessageProperties.PrefixText = "<font color='#ffeb3b'>[VIP] "..arg1.PrefixText.."</font>"
			return TextChatMessageProperties
		end
		TextChatMessageProperties.PrefixText = "<font color='#9e9e9e'>"..arg1.PrefixText.."</font>"
	end
	return TextChatMessageProperties
end