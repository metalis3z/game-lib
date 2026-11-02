-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:11:39 2025 ]]
return {
    CreatedPost = function(_, v1) --[[ Line: 3 ]] --[[ Name: CreatedPost ]]
        local v2 = false;
        local function v6() --[[ Line: 6 ]] --[[ Name: getEclipsed ]]
            -- upvalues: v2 (ref), v1 (copy)
            if v2 then
                return;
            else
                v2 = true;
                local l_Rig_0 = v1.Rig;
                for _, v5 in pairs(l_Rig_0:GetChildren()) do
                    if v5:FindFirstChildWhichIsA("Attachment") then
                        v5.Color = Color3.fromRGB(255, 255, 255);
                    end;
                end;
                l_Rig_0.Pants.PantsTemplate = script.Pants.PantsTemplate;
                l_Rig_0.Shirt.ShirtTemplate = script.Shirt.ShirtTemplate;
                l_Rig_0.TheDusekkar.Handle.Mesh.TextureId = "http://www.roblox.com/asset/?id=84381280398539";
                return;
            end;
        end;
        v1.Rig.Humanoid.Died:Once(function() --[[ Line: 25 ]]
            -- upvalues: v6 (copy)
            v6();
        end);
    end
};