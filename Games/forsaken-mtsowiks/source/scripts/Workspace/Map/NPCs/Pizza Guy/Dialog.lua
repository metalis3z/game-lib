-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
local v2 = {
    ["PlayIdleOutsideOfDialog"] = true,
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
        p3:CreateDialog({
            ["Text"] = "i dont think im gonna get my paycheck after telling boss about this one"
        })
    else
        v_u_1.SpokenToBefore = true
        p3:CreateDialog({
            ["Text"] = "i was called to deliver some pizza earlier but i dont think this is the right house"
        })
        p3:CreateDialog({
            ["Text"] = "and i lost my car on the way here so now idk how to get back home"
        })
    end
end
return v_u_1