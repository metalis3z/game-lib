-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:11:19 2025 ]]
local v0 = {};
local v1 = {
    "rbxassetid://76438652263299", 
    "rbxassetid://90738871790220", 
    "rbxassetid://128400334757243"
};
v0.Created = function(_, v3) --[[ Line: 10 ]] --[[ Name: Created ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() then
        local l_ShirtGraphic_0 = Instance.new("ShirtGraphic");
        l_ShirtGraphic_0.Graphic = v1[math.random(1, #v1)];
        l_ShirtGraphic_0.Parent = v3.Rig;
    end;
end;
return v0;