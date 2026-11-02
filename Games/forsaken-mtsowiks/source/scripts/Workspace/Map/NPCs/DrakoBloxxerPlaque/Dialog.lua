-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = {
    ["FacePlayer"] = false,
    ["PlayIdleOutsideOfDialog"] = true,
    ["VoiceSFX"] = "rbxassetid://140647479280509",
    ["Poses"] = {
        ["Idle"] = "rbxassetid://180435571"
    },
    ["Actions"] = {
        ["Wave"] = "rbxassetid://128777973"
    }
}
v_u_1.Config = v2
function v_u_1.Interacted(p3)
    -- upvalues: (copy) v_u_1
    if v_u_1.SpokenToBefore then
        require(game.ReplicatedStorage.Modules.Sounds):Play("rbxassetid://1007368252", {
            ["Parent"] = script.Parent.PrimaryPart
        })
        p3:CreateDialog({
            ["Text"] = "<Color=Red>AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHH<Color=/>"
        })
    else
        v_u_1.SpokenToBefore = true
        p3:CreateDialog({
            ["Text"] = "<Color=Red>HELP<Color=/> I WAS STUCK ON THIS WALL AND I CANT GET OUT"
        })
        p3:CreateDialog({
            ["Text"] = "<Color=Red>DUDE<Color=/> AHHHHHHHHHHHH"
        })
    end
end
return v_u_1