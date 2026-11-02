-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:39 2025 ]]
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_RunService_0 = game:GetService("RunService");
local v2 = {
    Default = 135116458225335, 
    Happy = 76344445135517, 
    Death = 93155200613098, 
    Hurt = 124219276233155, 
    Injured = 137755212886741
};
return {
    CreatedPost = function(_, v4) --[[ Line: 16 ]] --[[ Name: CreatedPost ]]
        -- upvalues: v2 (copy), l_ContentProvider_0 (copy), l_RunService_0 (copy)
        task.spawn(function() --[[ Line: 17 ]]
            -- upvalues: v2 (ref), l_ContentProvider_0 (ref), l_RunService_0 (ref), v4 (copy)
            local v5 = {};
            for _, v7 in v2 do
                table.insert(v5, "rbxassetid://" .. v7);
            end;
            l_ContentProvider_0:PreloadAsync(v5, function(v8, v9) --[[ Line: 23 ]]
                -- upvalues: l_RunService_0 (ref), v4 (ref)
                if l_RunService_0:IsStudio() then
                    warn((("[%*/PreloadAsync()]: Preload Status: %* on ID: %*"):format(v4.Rig, v9, v8)));
                end;
            end);
        end);
    end, 
    onExpressionChanged = function(_, v11, v12, _) --[[ Line: 31 ]] --[[ Name: onExpressionChanged ]]
        -- upvalues: v2 (copy)
        local l_Rig_0 = v11.Rig;
        if l_Rig_0 then
            l_Rig_0.Torso.SecondFaces.Texture = ("rbxassetid://%*"):format(v2[v12] or v2.Default);
        end;
    end
};