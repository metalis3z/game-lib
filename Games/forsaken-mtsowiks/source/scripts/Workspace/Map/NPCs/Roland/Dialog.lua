-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v3 = {
    ["PlayIdleOutsideOfDialog"] = true,
    ["VoiceSFX"] = "rbxassetid://95263724367762",
    ["Poses"] = {
        ["Idle"] = "rbxassetid://180435571"
    }
}
v_u_1.Config = v3
function v_u_1.Interacted(p4)
    -- upvalues: (copy) v_u_1, (copy) v_u_2
    if not v_u_1.TimesInteracted then
        v_u_1.TimesInteracted = 0
    end
    local v5 = v_u_1
    v5.TimesInteracted = v5.TimesInteracted + 1
    if v_u_1.TimesInteracted == 9 then
        script.Parent.Name = "Roland?"
    elseif v_u_1.TimesInteracted == 10 then
        script.Parent.Name = "Roland Cosplayer"
    end
    if v_u_1.TimesInteracted < 10 then
        local v6 = v_u_2
        local v7 = {}
        local v8 = (10 - v_u_1.TimesInteracted / 2 + 2) / 10
        v7.PlaybackSpeed = math.clamp(v8, 0.5, 1)
        local v9 = v6:Play("rbxassetid://73136812934449", v7)
        local v10 = ".."
        for _ = 1, v_u_1.TimesInteracted do
            v10 = v10 .. "."
        end
        p4:CreateDialog({
            ["Text"] = v10
        })
        game.TweenService:Create(v9, TweenInfo.new(0.25), {
            ["Volume"] = 0
        }):Play()
        game.Debris:AddItem(v9, 0.25)
        return
    elseif v_u_1.TimesInteracted == 10 then
        p4:CreateDialog({
            ["Text"] = "i dont rlly know how i got here to be honest with you"
        })
    else
        p4:CreateDialog({
            ["Text"] = "i wanna go back to the cosplay contest"
        })
    end
end
return v_u_1