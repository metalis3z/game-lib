-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = game:GetService("Players");
local v1 = game:GetService("ReplicatedStorage");
local v2 = game:GetService("TweenService");
local v3 = game:GetService("RunService");
local v4 = require(v1.Modules.Misc.Trove);
local v5 = workspace.CurrentCamera;
local v6 = v0.LocalPlayer;
if v6 then
    local v7 = v6:WaitForChild("PlayerGui", 5);
end;
local v8 = script:FindFirstAncestor("NosferatuChamber").Important:FindFirstChild("EventShopCamera");
local v9 = v1.Assets.EventStorage["2025_MASQUERADE"];
local v10 = require(v9.UI.EventShopClient);
local v11 = v3:IsStudio();
local v12 = script:GetFullName();
local v13 = TweenInfo.new(2.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local function v15(v14) --[[ Line: 31 ]] --[[ Name: __displayWarn ]]
    -- upvalues: v11 (copy), v12 (copy)
    assert(type(v14) == "string", "bad message");
    if not v11 then
        return;
    else
        warn((("[%*]: %*"):format(v12, v14)));
        return;
    end;
end;
local function v24(v16) --[[ Line: 41 ]] --[[ Name: hideCharacters ]]
    -- upvalues: v6 (copy), v0 (copy)
    if v6 and v6.Character and v6.Character.Parent.Name ~= "Spectating" then
        return;
    else
        for v17, v18 in v0:GetPlayers() do
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
local v25 = {
    __isInShop = false, 
    __internalTrove = v4.new(), 
    Config = {}
};
v25.Interacted = function() --[[ Line: 73 ]] --[[ Name: Interacted ]]
    -- upvalues: v5 (copy), v6 (copy), v25 (copy), v24 (copy), v10 (copy), v2 (copy), v13 (copy), v8 (copy)
    if not v5 or not v6 or v25.__isInShop then
        return;
    else
        v25.__isInShop = true;
        local function v26() --[[ Line: 80 ]] --[[ Name: __onCloseShop ]]
            -- upvalues: v25 (ref), v24 (ref), v5 (ref), v6 (ref)
            v25.__isInShop = false;
            v25.__internalTrove:Destroy();
            v24(false);
            if v5 then
                v5.CameraType = Enum.CameraType.Custom;
            end;
            v6:SetAttribute("FOVMultipliersDisabled", nil);
        end;
        v6:SetAttribute("FOVMultipliersDisabled", true);
        v24(true);
        v10:OpenUI(v26);
        v5.CameraType = Enum.CameraType.Scriptable;
        local v27 = v2:Create(v5, v13, {
            CFrame = v8.CFrame, 
            FieldOfView = 60
        });
        v27:Play();
        v25.__internalTrove:Add(v27, "Cancel");
        return;
    end;
end;
return v25;