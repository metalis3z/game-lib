-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    __isTransition = false
};
local v1 = game:GetService("Players");
local v2 = game:GetService("TweenService");
local v3 = game:GetService("ReplicatedStorage");
local v4 = workspace.CurrentCamera;
local v5 = v1.LocalPlayer;
local v6 = CFrame.new(-3582.625, 4.476, 185.553);
local v7 = v3:WaitForChild("Assets", 15);
local v8 = v7 and require(v7.EventStorage["2025_MASQUERADE"].POIs.Chamber);
local function v13(v9, v10, v11) --[[ Line: 20 ]] --[[ Name: fastTween ]]
    -- upvalues: v2 (copy)
    local v12 = v2:Create(v9, v10, v11);
    v12:Play();
    v12.Completed:Once(function() --[[ Line: 24 ]]
        -- upvalues: v12 (copy)
        v12:Destroy();
    end);
    return v12;
end;
local function v15() --[[ Line: 31 ]] --[[ Name: isInRound ]]
    -- upvalues: v5 (copy)
    local v14 = v5.Character;
    return v14 and v14.Parent and v14.Parent.Name ~= "Spectating";
end;
local function v24(v16) --[[ Line: 36 ]] --[[ Name: hideCharacters ]]
    -- upvalues: v5 (copy), v1 (copy)
    if v5.Character and v5.Character.Parent.Name ~= "Spectating" then
        print("CANNOT PROCEED AS THE PARENT IS NOT SPECTATING, CURRENT PARRENT NAME:", v5.Character.Parent.Name);
        return;
    else
        for v17, v18 in v1:GetPlayers() do
            local v19 = v18.Character;
            if v19 then
                for v20, v21 in v19:GetDescendants() do
                    if v21:IsA("BasePart") then
                        local v22 = v21.Transparency;
                        local v23 = v21:GetAttribute("hidden");
                        v21:SetAttribute("hidden", v22);
                        v21.Transparency = v16 and 1 or v23 or 0;
                    elseif v21:IsA("ParticleEmitter") or v21:IsA("Fire") then
                        v21.Enabled = not v16;
                    end;
                end;
            end;
        end;
        return;
    end;
end;
local function v35() --[[ Line: 62 ]] --[[ Name: onTransition ]]
    -- upvalues: v5 (copy), v0 (copy), v4 (copy), v24 (copy), v2 (copy), v6 (copy), v8 (copy)
    local v25 = v5.Character;
    if not v25 then
        v0.__isTransition = false;
        return;
    else
        v5.PlayerGui:WaitForChild("MainUI").Enabled = false;
        v4.CameraType = Enum.CameraType.Scriptable;
        v24(true);
        local v26 = v4;
        local v27 = TweenInfo.new(1.5);
        local v28 = {
            CFrame = script.Parent.DialogPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
        };
        local v29 = v2:Create(v26, v27, v28);
        v29:Play();
        local v30 = v29 --[[ copy: 4 -> 8 ]];
        v29.Completed:Once(function() --[[ Line: 24 ]]
            -- upvalues: v30 (copy)
            v30:Destroy();
        end);
        task.wait(0.5);
        v26 = Instance.new("ScreenGui");
        v26.IgnoreGuiInset = true;
        v26.Name = "BlackScreen";
        v27 = Instance.new("Frame");
        v27.BackgroundColor3 = Color3.new(0, 0, 0);
        v27.Parent = v26;
        v27.Size = UDim2.fromScale(1, 1);
        v27.Transparency = 1;
        v26.Parent = v5.PlayerGui;
        local v31 = TweenInfo.new(1);
        local v32 = {
            BackgroundTransparency = 0
        };
        local v33 = v2:Create(v27, v31, v32);
        v33:Play();
        local v34 = v33 --[[ copy: 7 -> 9 ]];
        v33.Completed:Once(function() --[[ Line: 24 ]]
            -- upvalues: v34 (copy)
            v34:Destroy();
        end);
        v33.Completed:Wait();
        v4.CameraType = Enum.CameraType.Custom;
        v24(false);
        v29 = v5.Character;
        if v29 and v29.Parent and v29.Parent.Name ~= "Spectating" then
            v0.__isTransition = false;
            v26:Destroy();
            return;
        else
            v25:PivotTo(v6);
            v4.CFrame = v4.CFrame * CFrame.Angles(0.5235987755982988, 0, 0);
            v8:DestroyLocation();
            task.wait(0.5);
            v31 = TweenInfo.new(1);
            v32 = {
                BackgroundTransparency = 1
            };
            v33 = v2:Create(v27, v31, v32);
            v33:Play();
            v33.Completed:Once(function() --[[ Line: 24 ]]
                -- upvalues: v33 (copy)
                v33:Destroy();
            end);
            v33.Completed:Once(function() --[[ Line: 114 ]]
                -- upvalues: v26 (copy)
                v26:Destroy();
            end);
            v5.PlayerGui.MainUI.Enabled = true;
            v0.__isTransition = false;
            return;
        end;
    end;
end;
v0.Config = {};
v0.Interacted = function(v36) --[[ Line: 125 ]]
    -- upvalues: v0 (copy), v35 (copy)
    if v0.__isTransition then
        return;
    else
        v0.__isTransition = true;
        task.spawn(v35);
        return;
    end;
end;
return v0;