-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved soon!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-01-02 08:18:29
-- Luau version 6, Types version 3
-- Time taken: 0.000680 seconds

local module = {}
local Trove_upvr = require(game.ReplicatedStorage.Packages.Trove)
local Menus_upvr = game.Players.LocalPlayer.PlayerGui:WaitForChild("Menus")
local Run_Service_upvr = game["Run Service"]
function module.Start(arg1, arg2, arg3) -- Line 16
    --[[ Upvalues[3]:
        [1]: Trove_upvr (readonly)
        [2]: Menus_upvr (readonly)
        [3]: Run_Service_upvr (readonly)
    ]]
    local any_new_result1_upvr = Trove_upvr.new()
    Menus_upvr.FPSCounter.Visible = arg2.Value
    local function _(arg1_2) -- Line 22
        --[[ Upvalues[1]:
            [1]: Menus_upvr (copied, readonly)
        ]]
        Menus_upvr.FPSCounter.FPS.Text = tostring(math.floor(1 / arg1_2).." FPS")
    end
    local function _() -- Line 27
        --[[ Upvalues[1]:
            [1]: any_new_result1_upvr (readonly)
        ]]
        any_new_result1_upvr:Clean()
    end
end
return module