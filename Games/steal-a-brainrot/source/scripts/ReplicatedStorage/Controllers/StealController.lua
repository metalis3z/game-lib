-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local _ = game:GetService("ServerStorage");
local _ = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v5 = require(l_ReplicatedStorage_0.Packages.ReplicatorClient);
local _ = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v7 = require(l_ReplicatedStorage_0.Packages.Gradients);
local _ = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Packages.Debounce);
local v10 = require(l_ReplicatedStorage_0.Packages.Trove);
local v11 = require(l_ReplicatedStorage_0.Packages.Timer);
local _ = require(l_ReplicatedStorage_0.Packages.Spr);
local v13 = require(l_ReplicatedStorage_0.Packages.Net);
local v14 = require(l_ReplicatedStorage_0.Controllers.FastOverheadController);
local _ = require(l_ReplicatedStorage_0.Controllers.ConfirmationController);
local _ = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local _ = require(l_ReplicatedStorage_0.Controllers.CharacterController);
local _ = require(l_ReplicatedStorage_0.Controllers.ShopController);
local v19 = require(l_ReplicatedStorage_0.Shared.Animals);
local v20 = require(l_ReplicatedStorage_0.Datas.Rarities);
local _ = require(l_ReplicatedStorage_0.Datas.ServerData);
local v22 = require(l_ReplicatedStorage_0.Datas.Animals);
local v23 = require(l_ReplicatedStorage_0.Datas.Mutations);
local v24 = require(l_ReplicatedStorage_0.Datas.Traits);
local v25 = require(l_ReplicatedStorage_0.Utils.NumberUtils);
local _ = require(l_ReplicatedStorage_0.Utils.MathUtils);
local _ = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v28 = v13:RemoteEvent("StealService/GrabDroppedBrainrot");
local _ = l_Players_0.LocalPlayer;
local v30 = {};
local v31 = {};
v30.StartBrainrotRendering = function(_) --[[ Line: 76 ]] --[[ Name: StartBrainrotRendering ]]
    -- upvalues: v5 (copy), v31 (copy), v10 (copy), v19 (copy), v22 (copy), v20 (copy), v14 (copy), v25 (copy), v23 (copy), v7 (copy), v24 (copy), v11 (copy), v28 (copy)
    local v33 = v5.get("Steal/DroppedBrainrots");
    v33:WaitForLoaded();
    local function _(v34) --[[ Line: 80 ]] --[[ Name: destroyBrainrot ]]
        -- upvalues: v31 (ref)
        local v35 = v31[v34];
        if v35 then
            v35.trove:Destroy();
            v31[v34] = nil;
        end;
    end;
    local function v63(v37) --[[ Line: 88 ]] --[[ Name: renderBrainrot ]]
        -- upvalues: v31 (ref), v33 (copy), v10 (ref), v19 (ref), v22 (ref), v20 (ref), v14 (ref), v25 (ref), v23 (ref), v7 (ref), v24 (ref), v11 (ref), v28 (ref)
        if v31[v37] then
            return;
        else
            local v38 = v33:Path({
                "brainrots", 
                v37
            });
            local v39 = v10.new();
            local v40 = v39:Extend();
            local _ = v39:Extend();
            v31[v37] = {
                trove = v39, 
                model = nil
            };
            local function v62() --[[ Line: 104 ]] --[[ Name: updateBrainrotModel ]]
                -- upvalues: v40 (copy), v33 (ref), v38 (copy), v19 (ref), v31 (ref), v37 (copy), v22 (ref), v20 (ref), v14 (ref), v25 (ref), v23 (ref), v7 (ref), v24 (ref), v11 (ref), v28 (ref)
                v40:Destroy();
                local v42 = v33:TryIndex(v38());
                if not v42 then
                    return;
                else
                    local l_v19_AnimatedModel_0 = v19:GetAnimatedModel(v42.data.Index, "Idle");
                    assert(l_v19_AnimatedModel_0);
                    v40:Add(l_v19_AnimatedModel_0);
                    v31[v37].model = v40;
                    v40:Add(function() --[[ Line: 117 ]]
                        -- upvalues: v31 (ref), v37 (ref)
                        if v31[v37] then
                            v31[v37].model = nil;
                        end;
                    end);
                    assert(l_v19_AnimatedModel_0.PrimaryPart, (("%* has no PrimaryPart"):format(v42)));
                    local v44 = v22[v42.data.Index];
                    local v45 = v20[v44.Rarity];
                    local function v46() --[[ Line: 128 ]] --[[ Name: updateCFrame ]]
                        -- upvalues: v42 (copy), l_v19_AnimatedModel_0 (copy)
                        if v42.grabbed then
                            l_v19_AnimatedModel_0:PivotTo(CFrame.new(10000, 10000, 10000));
                            return;
                        else
                            l_v19_AnimatedModel_0:PivotTo(v42.cframe);
                            return;
                        end;
                    end;
                    v40:Add(v33:Listen(v38("cframe"), v46));
                    v40:Add(v33:Listen(v38("grabbed"), v46));
                    v40:Add(task.defer(v46));
                    l_v19_AnimatedModel_0.PrimaryPart.Anchored = true;
                    if v42.data.Traits then
                        v19:ApplyTraits(l_v19_AnimatedModel_0, v42.data.Index, v42.data.Traits);
                    end;
                    if v42.data.Mutation then
                        v19:ApplyMutation(l_v19_AnimatedModel_0, v42.data.Index, v42.data.Mutation);
                    end;
                    local l_l_v19_AnimatedModel_0_FirstChild_0 = l_v19_AnimatedModel_0:FindFirstChild("OVERHEAD_ATTACHMENT", true);
                    if not l_l_v19_AnimatedModel_0_FirstChild_0 then
                        local l_Attachment_0 = Instance.new("Attachment");
                        local l_l_v19_AnimatedModel_0_ExtentsSize_0 = l_v19_AnimatedModel_0:GetExtentsSize();
                        l_Attachment_0.CFrame = CFrame.new(0, l_l_v19_AnimatedModel_0_ExtentsSize_0.Y * 0.5, 0);
                        l_Attachment_0.Parent = l_v19_AnimatedModel_0.PrimaryPart;
                        l_l_v19_AnimatedModel_0_FirstChild_0 = l_Attachment_0;
                    end;
                    local v50, v51 = v14.createFastOverhead({
                        adornee = l_l_v19_AnimatedModel_0_FirstChild_0, 
                        guiTemplate = v14.GuiTemplates.AnimalOverhead
                    });
                    v40:Add(v51);
                    local l_Generation_0 = v50.Generation;
                    v50.Stolen.Visible = false;
                    local function v53() --[[ Line: 172 ]] --[[ Name: updateOverhead ]]
                        -- upvalues: l_Generation_0 (copy), v25 (ref), v19 (ref), v42 (copy)
                        l_Generation_0.Text = ("$%*/s"):format((v25:ToString(v19:GetGeneration(v42.data.Index, v42.data.Mutation, v42.data.Traits, nil))));
                    end;
                    v50.DisplayName.Text = v44.DisplayName;
                    v50.Price.Text = ("$%*"):format((v25:ToString(v19:GetPrice(v42.data.Index))));
                    v50.Rarity.Text = v44.Rarity;
                    v50.Rarity.TextColor3 = v20[v44.Rarity].Color;
                    if v42.data.Mutation then
                        local v54 = v23[v42.data.Mutation];
                        v50.Mutation.Text = v54.DisplayText;
                        if v54.GradientPreset then
                            v40:Add(v7.apply(v50.Mutation, v54.GradientPreset));
                        else
                            v50.Mutation.TextColor3 = v54.MainColor;
                        end;
                    end;
                    if v42.data.Traits then
                        local l_Template_0 = v50.Traits.Template;
                        for _, v57 in v42.data.Traits do
                            local v58 = v24[v57];
                            if v58 then
                                local v59 = l_Template_0:Clone();
                                v59.Parent = l_Template_0.Parent;
                                v59.Image = v58.Icon;
                                v59.Visible = true;
                            end;
                        end;
                        v50.Traits.Visible = true;
                    end;
                    task.spawn(v53);
                    v40:Add(v11.Simple(1, v53));
                    v40:Add(v33:Listen(v38("timer"), v53));
                    v50.Mutation.Visible = v42.data.Mutation ~= nil;
                    if v20[v44.Rarity].StrokeColor then
                        v50.Rarity.UIStroke.Color = v20[v44.Rarity].StrokeColor;
                    end;
                    if v45.GradientPreset then
                        v40:Add(v7.apply(v50.Rarity, v45.GradientPreset));
                    end;
                    v50.Parent = l_l_v19_AnimatedModel_0_FirstChild_0;
                    local v60 = v40:Add(Instance.new("ProximityPrompt"));
                    v60.ActionText = "Grab";
                    v60.ObjectText = v42.data.Index;
                    v60.HoldDuration = 2;
                    v60.RequiresLineOfSight = false;
                    v60.MaxActivationDistance = 10;
                    v60.Parent = l_v19_AnimatedModel_0.PrimaryPart;
                    v40:Add(v60.Triggered:Connect(function(v61) --[[ Line: 231 ]]
                        -- upvalues: v28 (ref), v37 (ref)
                        if not v61.Character then
                            return;
                        else
                            v28:FireServer(v37);
                            return;
                        end;
                    end));
                    return;
                end;
            end;
            v39:Add(v33:Listen(v38("mutation"), function() --[[ Line: 240 ]]
                -- upvalues: v62 (copy)
                v62();
            end));
            v39:Add(v33:Listen(v38("traits"), function() --[[ Line: 244 ]]
                -- upvalues: v62 (copy)
                v62();
            end));
            v39:Add(task.spawn(v62));
            return v39;
        end;
    end;
    v33:Observe({
        "brainrots"
    }, function(v64, v65) --[[ Line: 253 ]]
        -- upvalues: v31 (ref), v63 (copy)
        if v64 == nil then
            for v66 in v31 do
                local v67 = v31[v66];
                if v67 then
                    v67.trove:Destroy();
                    v31[v66] = nil;
                end;
            end;
            return;
        else
            for v68 in v64 do
                if not v31[v68] then
                    v63(v68);
                end;
            end;
            if v65 ~= nil then
                for v69 in v31 do
                    if not v64[v69] then
                        local v70 = v31[v69];
                        if v70 then
                            v70.trove:Destroy();
                            v31[v69] = nil;
                        end;
                    end;
                end;
            end;
            return;
        end;
    end);
end;
v30.GetBrainrot = function(_, v72) --[[ Line: 280 ]] --[[ Name: GetBrainrot ]]
    -- upvalues: v5 (copy)
    return v5.get("TsunamiEvent/Brainrots"):TryIndex({
        "brainrots", 
        v72
    });
end;
v30.GetBrainrotCFrame = function(_, v74, v75) --[[ Line: 285 ]] --[[ Name: GetBrainrotCFrame ]]
    -- upvalues: v30 (copy), v31 (copy), l_CollectionService_0 (copy)
    local l_v30_Brainrot_0 = v30:GetBrainrot(v74);
    if not l_v30_Brainrot_0 then
        return nil, nil;
    elseif not v31[v74] then
        return nil, nil;
    else
        local l_model_0 = v31[v74].model;
        if not l_model_0 then
            return nil, nil;
        elseif not v75 then
            local v78 = l_v30_Brainrot_0.grabbed and l_CollectionService_0:GetTags((("Held_%*"):format(l_v30_Brainrot_0.grabbed)))[1];
            if not v78 then
                return l_v30_Brainrot_0.cframe, l_model_0;
            else
                local _ = nil;
                return (if v78.PrimaryPart then v78.PrimaryPart.CFrame else v78:GetPivot()) + Vector3.new(0, v78:GetExtentsSize().Y * 0.5, 0), l_model_0;
            end;
        else
            return l_v30_Brainrot_0.cframe, l_model_0;
        end;
    end;
end;
v30.Start = function(_) --[[ Line: 319 ]] --[[ Name: Start ]]
    -- upvalues: v30 (copy)
    task.spawn(v30.StartBrainrotRendering, v30);
end;
return v30;
