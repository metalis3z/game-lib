-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v18 = {
    Metadata = {}, 
    Start = function(v0) --[[ Line: 8 ]] --[[ Name: Start ]]
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Character_0 = l_LocalPlayer_0.Character;
        local v3 = l_Character_0 and l_Character_0:WaitForChild("Humanoid", 20);
        local v6 = {
            Speed = {
                GetBaseValue = function() --[[ Line: 16 ]] --[[ Name: GetBaseValue ]]
                    -- upvalues: v3 (copy)
                    return v3 and v3:GetAttribute("BaseSpeed");
                end, 
                SetValue = function(v4) --[[ Line: 20 ]] --[[ Name: SetValue ]]
                    -- upvalues: v3 (copy)
                    if v3 and v3.WalkSpeed ~= v4 then
                        v3.WalkSpeed = v4;
                    end;
                end
            }, 
            FOV = {
                GetBaseValue = function() --[[ Line: 27 ]] --[[ Name: GetBaseValue ]]
                    return 70;
                end, 
                SetValue = function(v5) --[[ Line: 31 ]] --[[ Name: SetValue ]]
                    if workspace.CurrentCamera.FieldOfView ~= v5 then
                        workspace.CurrentCamera.FieldOfView = v5;
                    end;
                end
            }
        };
        local v7 = {};
        for v8, _ in pairs(v6) do
            local v10 = l_Character_0 and l_Character_0:WaitForChild(("%*Multipliers"):format(v8), 20);
            if v10 then
                v7[v8] = v10;
            end;
        end;
        v0.Connection = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 48 ]]
            -- upvalues: v7 (copy), l_LocalPlayer_0 (copy), v6 (copy)
            for v11, v12 in pairs(v7) do
                if not l_LocalPlayer_0:GetAttribute((("%*MultipliersDisabled"):format(v11))) then
                    local v13 = v6[v11];
                    local v14 = v13.GetBaseValue();
                    if v14 then
                        local l_v14_0 = v14;
                        for _, v17 in pairs(v12:GetChildren()) do
                            l_v14_0 = l_v14_0 * v17.Value;
                        end;
                        v13.SetValue(l_v14_0);
                    end;
                end;
            end;
        end);
    end
};
v18.Destroy = function(v19) --[[ Line: 68 ]] --[[ Name: Destroy ]]
    -- upvalues: v18 (copy)
    if v19.Connection then
        v19.Connection:Disconnect();
        v19.Connection = nil;
    end;
    table.clear(v18.Metadata);
end;
return v18;