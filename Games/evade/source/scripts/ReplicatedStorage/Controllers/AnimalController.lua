-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v3 = require(l_Packages_0.Observers);
local v4 = require(l_Packages_0.Synchronizer);
local v5 = require(l_Packages_0.Signal);
local v6 = require(l_ReplicatedStorage_0.Packages.Net);
local v7 = require(l_ReplicatedStorage_0.Packages.Trove);
local l_Classes_0 = l_ReplicatedStorage_0:WaitForChild("Classes");
local v9 = require(l_Classes_0.AnimalClient);
local v10 = {};
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_FireServer_0 = Instance.new("RemoteEvent").FireServer;
local v13 = v6:RemoteEvent("156ed911-fc4b-4d24-a648-acd1e9761e4f");
local v14 = v6:RemoteEvent("f756228f-15f8-4b6d-93a4-dfe62bb409cb");
local v33 = {
    OnAnimalSpawn = v5.new(), 
    OnAnimalDestroyed = v5.new(), 
    OnFollowingChanged = v5.new(), 
    HasAnimalMovingToBase = function(_, _) --[[ Line: 35 ]] --[[ Name: HasAnimalMovingToBase ]]
        -- upvalues: v10 (copy), l_LocalPlayer_0 (copy)
        for _, v18 in pairs(v10) do
            local l_Instance_0 = v18.Instance;
            local v20 = l_Instance_0 and l_Instance_0.PrimaryPart;
            local v21 = v20 and v20:FindFirstChild("PromptAttachment");
            local v22 = v21 and v21:FindFirstChild("ProximityPrompt");
            if v22 and v22:GetAttribute("TargetPlayer") == l_LocalPlayer_0.UserId then
                return v18;
            end;
        end;
    end, 
    HasAnimal = function(_, v24, v25) --[[ Line: 52 ]] --[[ Name: HasAnimal ]]
        -- upvalues: v4 (copy), l_LocalPlayer_0 (copy)
        local v26 = v25 or 1;
        local v27 = v4:Get(l_LocalPlayer_0);
        if not v27 then
            return false;
        else
            local v28 = 0;
            local v29 = {};
            for v30, v31 in v27:Get("AnimalPodiums") do
                if v31 ~= "Empty" and v31.Index == v24 then
                    v28 = v28 + 1;
                    table.insert(v29, v30);
                end;
            end;
            return v26 <= v28, v29;
        end;
    end, 
    GetAnimals = function(_) --[[ Line: 75 ]] --[[ Name: GetAnimals ]]
        -- upvalues: v10 (copy)
        return v10;
    end
};
v33.Start = function(_) --[[ Line: 79 ]] --[[ Name: Start ]]
    -- upvalues: v3 (copy), v9 (copy), v10 (copy), v33 (copy), v7 (copy), l_LocalPlayer_0 (copy), l_FireServer_0 (copy), v14 (copy), v13 (copy)
    v3.observeTag("Animal", function(v35) --[[ Line: 81 ]]
        -- upvalues: v9 (ref), v10 (ref), v3 (ref), v33 (ref)
        local v36 = v9.new(v35);
        v10[v36:GetUID()] = v36;
        v36.Collector:Add(v3.observeTag("AnimalPurchasePrompt", function(v37) --[[ Line: 87 ]]
            -- upvalues: v3 (ref), v33 (ref), v36 (copy)
            return v3.observeAttribute(v37, "TargetPlayer", function(v38) --[[ Line: 88 ]]
                -- upvalues: v33 (ref), v36 (ref)
                v33.OnFollowingChanged:Fire(v36.Index, v36.UID, v38);
                return nil;
            end);
        end, {
            v36.Instance
        }));
        v33.OnAnimalSpawn:Fire(v36);
        return function() --[[ Line: 96 ]]
            -- upvalues: v36 (copy), v10 (ref), v33 (ref)
            local l_UID_0 = v36.UID;
            v36:Destroy();
            v10[l_UID_0] = nil;
            v33.OnAnimalDestroyed:Fire(l_UID_0);
        end;
    end);
    v3.observeTag("AnimalPurchasePrompt", function(v40) --[[ Line: 106 ]]
        -- upvalues: v7 (ref), l_LocalPlayer_0 (ref), l_FireServer_0 (ref), v14 (ref), v13 (ref)
        local v41 = v7.new();
        local function v44() --[[ Line: 108 ]] --[[ Name: updateVisibility ]]
            -- upvalues: v40 (copy), l_LocalPlayer_0 (ref)
            local l_v40_0 = v40;
            local v43 = false;
            if v40:GetAttribute("TargetPlayer") ~= l_LocalPlayer_0.UserId then
                v43 = not v40:GetAttribute("Disabled");
            end;
            l_v40_0.Enabled = v43;
        end;
        v41:Add(v40:GetAttributeChangedSignal("TargetPlayer"):Connect(v44));
        v41:Add(v40:GetAttributeChangedSignal("Disabled"):Connect(v44));
        local v45 = false;
        if v40:GetAttribute("TargetPlayer") ~= l_LocalPlayer_0.UserId then
            v45 = not v40:GetAttribute("Disabled");
        end;
        v40.Enabled = v45;
        v45 = v40:GetAttribute("UID");
        v41:Add(v40.PromptButtonHoldBegan:Connect(function() --[[ Line: 118 ]]
            -- upvalues: l_FireServer_0 (ref), v14 (ref)
            l_FireServer_0(v14, workspace:GetServerTimeNow() + 142, "fa977cd5-427c-407c-a672-f287d64070ce");
            v14:FireServer(workspace:GetServerTimeNow() + 142, "a522d125-48d8-497c-a586-d42e60018a78");
        end));
        v41:Add(v40.Triggered:Connect(function() --[[ Line: 139 ]]
            -- upvalues: l_FireServer_0 (ref), v13 (ref), v45 (copy)
            l_FireServer_0(v13, workspace:GetServerTimeNow() + 159, "bee1f514-73ec-4598-8df6-e25dd89b6f73", v45);
            v13:FireServer(workspace:GetServerTimeNow() + 159, "338d0008-b86e-45c8-b1f6-50aaf710e48d", v45);
        end));
        return function() --[[ Line: 163 ]]
            -- upvalues: v41 (copy)
            v41:Destroy();
        end;
    end);
end;
return v33;