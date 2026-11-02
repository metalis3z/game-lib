-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:36
-- Luau version 6, Types version 3
-- Time taken: 0.003098 seconds

while not _G.ClientDataReady do
	wait()
end
local CLIENT_DATA_upvr = _G.CLIENT_DATA
local Parent = script.Parent
local XP_upvr = require(game:GetService("ReplicatedStorage").XP)
local exp_upvw = CLIENT_DATA_upvr.data.exp
local level_upvw = CLIENT_DATA_upvr.data.level
local Level_upvr = Parent.Level
Level_upvr.Exp.Size = UDim2.new(exp_upvw / XP_upvr[level_upvw], 0, 0, 4)
Level_upvr.Title.Text = level_upvw
local Ding2_upvr = Parent.Ding2
local Ding_upvr = Parent.Ding
function UpdateLevel() -- Line 20
	--[[ Upvalues[7]:
		[1]: CLIENT_DATA_upvr (readonly)
		[2]: level_upvw (read and write)
		[3]: Ding2_upvr (readonly)
		[4]: Level_upvr (readonly)
		[5]: exp_upvw (read and write)
		[6]: Ding_upvr (readonly)
		[7]: XP_upvr (readonly)
	]]
	local data = CLIENT_DATA_upvr.data
	if data.level ~= level_upvw then
		Ding2_upvr:Play()
		Level_upvr.Title.Text = data.level
		level_upvw = data.level
		_G.message("Reward", "LEVEL UP!", Color3.new(1, 0, 1))
	end
	if data.exp ~= exp_upvw then
		local var10 = data.exp - exp_upvw
		exp_upvw = data.exp
		Ding_upvr:Play()
		if 0 < var10 then
			Level_upvr.Exp.Size = UDim2.new(data.exp / XP_upvr[data.level], 0, 0, 4)
			_G.message("Reward", "+ "..var10.." XP", Color3.new(0, 1, 1))
		end
		Level_upvr.Exp.Size = UDim2.new(data.exp / XP_upvr[data.level], 0, 0, 4)
	end
end
CLIENT_DATA_upvr.change.Event:connect(UpdateLevel)