-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:32
-- Luau version 6, Types version 3
-- Time taken: 0.002104 seconds

local Status = game:GetService("ReplicatedStorage").Status
local Parent = script.Parent
_G.Mode = "nil"
local Title_upvr = Parent.Title
function updateTitle(arg1) -- Line 10
	--[[ Upvalues[1]:
		[1]: Title_upvr (readonly)
	]]
	Title_upvr.Text = arg1
	Title_upvr.Shadow.Text = Title_upvr.Text
end
local Timer_upvr = Parent.Timer
function updateTimer(arg1) -- Line 15
	--[[ Upvalues[1]:
		[1]: Timer_upvr (readonly)
	]]
	if arg1 == 0 then
	end
	Timer_upvr.Text = ""
	Timer_upvr.Shadow.Text = Timer_upvr.Text
end
local Mode_upvr = Parent.Mode
function updateMode(arg1) -- Line 23
	--[[ Upvalues[1]:
		[1]: Mode_upvr (readonly)
	]]
	if arg1 ~= "" then
		_G.Mode = arg1
	end
	print("_G.Mode", _G.Mode)
	Mode_upvr.Text = arg1
	Mode_upvr.Shadow.Text = Mode_upvr.Text
end
updateTitle(Status.Title.Value)
updateTimer(Status.Timer.Value)
updateMode(Status.Mode.Value)
Status.Title.Changed:connect(function(arg1) -- Line 37
	updateTitle(arg1)
end)
Status.Timer.Changed:connect(function(arg1) -- Line 41
	updateTimer(arg1)
end)
Status.Mode.Changed:connect(function(arg1) -- Line 45
	updateMode(arg1)
end)