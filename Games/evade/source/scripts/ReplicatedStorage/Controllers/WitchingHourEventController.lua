-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ProximityPromptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ContentProvider");
local _ = game:GetService("SoundService");
local _ = game:GetService("TweenService");
local _ = game:GetService("HttpService");
local _ = game:GetService("RunService");
local _ = game:GetService("StarterGui");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Packages.Serialization);
local v10 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local _ = require(l_ReplicatedStorage_0.Packages.CreateTween);
local _ = require(l_ReplicatedStorage_0.Packages.TopbarPlus);
local v13 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v14 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Packages.Moonlite);
local _ = require(l_ReplicatedStorage_0.Packages.Squash);
local v17 = require(l_ReplicatedStorage_0.Packages.FFlags);
local v18 = require(l_ReplicatedStorage_0.Packages.Timer);
local v19 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = require(l_ReplicatedStorage_0.Packages.Spr);
local v21 = require(l_ReplicatedStorage_0.Packages.Net);
local _ = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local _ = require(l_ReplicatedStorage_0.Controllers.NewPlayersController);
local v24 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local _ = require(l_ReplicatedStorage_0.Controllers.CharacterController);
local v26 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local _ = require(l_ReplicatedStorage_0.Controllers.PlotController);
local v28 = require(l_ReplicatedStorage_0.Utils.NumberUtils);
local _ = require(l_ReplicatedStorage_0.Utils.TimeUtils);
local _ = require(l_ReplicatedStorage_0.Shared.VFX);
local v31 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local _ = require(l_ReplicatedStorage_0.Shared.Updates);
local _ = require(l_ReplicatedStorage_0.Shared.Animals);
local v34 = require(l_ReplicatedStorage_0.Shared.Animals);
local _ = require(l_ReplicatedStorage_0.Shared.Index);
local _ = require(l_ReplicatedStorage_0.Datas.Mutations);
local v37 = require(l_ReplicatedStorage_0.Datas.Rarities);
local v38 = require(l_ReplicatedStorage_0.Datas.Animals);
local v39 = require(l_ReplicatedStorage_0.Datas.StockMachine);
local v40 = v21:RemoteEvent("StockEventService/SetFocused");
local v41 = v21:RemoteEvent("StockEventService/Return");
local v42 = v21:RemoteEvent("StockEventService/Redeem");
local v43 = v21:RemoteFunction("StockEventService/Delivery");
local v44 = v39.WitchingHour["La Spooky Grande"];
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_WitchingHourMachine_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("WitchingHourMachine").WitchingHourMachine;
local l_Content_0 = l_WitchingHourMachine_0.Content;
local l_Redeem_0 = l_WitchingHourMachine_0.Redeem;
local l_Close_0 = l_WitchingHourMachine_0.Header.Close;
local v50 = nil;
return {
    Setup = function(_) --[[ Line: 84 ]] --[[ Name: Setup ]]
        -- upvalues: v10 (copy), l_LocalPlayer_0 (copy), v38 (copy), v37 (copy), v13 (copy), v34 (copy), l_Content_0 (copy), l_WitchingHourMachine_0 (copy), v44 (copy), v31 (copy), v41 (copy), l_Redeem_0 (copy), v42 (copy), v24 (copy), l_ReplicatedStorage_0 (copy), v28 (copy)
        local v52 = v10:Wait(l_LocalPlayer_0);
        if not v52 then
            return;
        else
            local function v57(v53, v54) --[[ Line: 90 ]] --[[ Name: renderBrainrotAtFrame ]]
                -- upvalues: v38 (ref), v37 (ref), v13 (ref), v34 (ref)
                local v55 = v38[v54];
                if not v55 then
                    return;
                else
                    local v56 = v37[v55.Rarity];
                    v53.Title.Text = v54;
                    if v56.GradientPreset then
                        v53.UIStroke.Color = Color3.new(1, 1, 1);
                        v53.Title.TextColor3 = Color3.new(1, 1, 1);
                        v13.apply(v53.UIStroke, v56.GradientPreset);
                        v13.apply(v53.Title, v56.GradientPreset);
                    else
                        v53.UIStroke.Color = v56.Color;
                        v53.Title.TextColor3 = v56.Color;
                    end;
                    v53.Visible = true;
                    v53.ViewportFrame.ImageColor3 = Color3.new(0, 0, 0);
                    v34:AttachOnViewport(v54, v53.ViewportFrame, true);
                    return;
                end;
            end;
            l_Content_0.Visible = true;
            v57(l_WitchingHourMachine_0.Main.Brainrot, v44.Output);
            v13.apply(l_WitchingHourMachine_0.Main.Holder.Description, "Rainbow");
            local v58 = {};
            for v59, v60 in v44.Inputs do
                local v61 = v38[v60];
                if v61 then
                    local v62 = v37[v61.Rarity];
                    local v63 = l_Content_0.Template:Clone();
                    v63.LayoutOrder = v62.Weight * 100 + v59;
                    v57(v63, v60);
                    v63.Return.Visible = false;
                    v63.Parent = l_Content_0;
                    if not v58[v60] then
                        v58[v60] = {};
                    end;
                    table.insert(v58[v60], v63);
                    local v64 = v31.new(v63.Return);
                    v64:Animate();
                    v64.OnActivated:Connect(function() --[[ Line: 142 ]]
                        -- upvalues: v52 (copy), v60 (copy), v41 (ref)
                        for v65, v66 in (v52:Get("AnimalPodiums")) do
                            if type(v66) == "table" and v66.Index == v60 and v66.Machine and v66.Machine.Type == "WitchingHour" and not v66.Machine.Active then
                                v41:FireServer("WitchingHour", v65);
                                return;
                            end;
                        end;
                    end);
                end;
            end;
            local function v78() --[[ Line: 153 ]] --[[ Name: updateBrainrotFrame ]]
                -- upvalues: v52 (copy), v58 (copy), l_Redeem_0 (ref)
                local v67 = v52:Get("AnimalPodiums");
                local v68 = {};
                for _, v70 in v67 do
                    if type(v70) == "table" and v70.Machine and v70.Machine.Type == "WitchingHour" and not v70.Machine.Active then
                        v68[v70.Index] = (v68[v70.Index] or 0) + 1;
                    end;
                end;
                local v71 = true;
                for v72, v73 in v58 do
                    local v74 = v68[v72] or 0;
                    for v75, v76 in v73 do
                        local v77 = v75 <= v74;
                        v76.Return.Visible = v77;
                        v76.ViewportFrame.ImageColor3 = if v77 then Color3.new(1, 1, 1) else Color3.new(0, 0, 0);
                        if not v77 then
                            v71 = false;
                        end;
                    end;
                end;
                l_Redeem_0.Interactable = v71;
                l_Redeem_0.BackgroundColor3 = if v71 then Color3.fromRGB(81, 158, 86) else Color3.fromRGB(127, 127, 127);
            end;
            v52:OnChanged("AnimalAddedOrRemoved", v78);
            task.spawn(v78);
            local v79 = v31.new(l_Redeem_0);
            v79:Animate();
            v79.OnActivated:Connect(function() --[[ Line: 188 ]]
                -- upvalues: v42 (ref), v24 (ref)
                v42:FireServer("WitchingHour", "La Spooky Grande");
                v24:SetState("WitchingHourMachine", false);
            end);
            local l_Stock_0 = l_WitchingHourMachine_0.Main.Holder.Stock;
            local v81 = ("StockEvent_%*"):format((string.gsub("La Spooky Grande", "%s", "_")));
            local function v83() --[[ Line: 199 ]] --[[ Name: updateStock ]]
                -- upvalues: l_ReplicatedStorage_0 (ref), v81 (copy), l_Stock_0 (copy), v28 (ref)
                local l_l_ReplicatedStorage_0_Attribute_0 = l_ReplicatedStorage_0:GetAttribute(v81);
                l_Stock_0.TextColor3 = Color3.fromRGB(255, 255, 255);
                if l_l_ReplicatedStorage_0_Attribute_0 == nil or l_l_ReplicatedStorage_0_Attribute_0 > 0 then
                    l_Stock_0.Text = l_l_ReplicatedStorage_0_Attribute_0 and ("%* Left"):format((v28:Comma(l_l_ReplicatedStorage_0_Attribute_0))) or "Loading...";
                    return;
                else
                    l_Stock_0.TextColor3 = Color3.fromRGB(255, 0, 0);
                    l_Stock_0.Text = "SOLD OUT";
                    return;
                end;
            end;
            l_ReplicatedStorage_0:GetAttributeChangedSignal(v81):Connect(v83);
            task.spawn(v83);
            return;
        end;
    end, 
    Start = function(v84) --[[ Line: 223 ]] --[[ Name: Start ]]
        -- upvalues: l_WitchingHourMachine_0 (copy), v50 (ref), v24 (copy), l_Close_0 (copy), v40 (copy), v14 (copy), v19 (copy), v10 (copy), l_LocalPlayer_0 (copy), v17 (copy), v18 (copy), l_Players_0 (copy), v43 (copy), v26 (copy), l_ReplicatedStorage_0 (copy)
        l_WitchingHourMachine_0.Visible = false;
        v50 = v24:Register("WitchingHourMachine", l_WitchingHourMachine_0, "TopQuint");
        v50:AttachCloseButton(l_Close_0);
        v50:Close();
        v50.OnOpen:Connect(function() --[[ Line: 230 ]]
            -- upvalues: v40 (ref)
            v40:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", "WitchingHour", true);
        end);
        v50.OnClose:Connect(function() --[[ Line: 234 ]]
            -- upvalues: v40 (ref)
            v40:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", "WitchingHour", false);
        end);
        task.spawn(v84.Setup, v84);
        v14.observeTag("WitchingHourMachinePrompt", function(v85) --[[ Line: 240 ]]
            -- upvalues: v19 (ref), v10 (ref), l_LocalPlayer_0 (ref), v17 (ref), v14 (ref), v18 (ref), v24 (ref)
            local v86 = v19.new();
            local v87 = v86:Extend();
            local v88 = nil;
            local function v92() --[[ Line: 247 ]] --[[ Name: updatePrompt ]]
                -- upvalues: v10 (ref), l_LocalPlayer_0 (ref), v85 (copy), v17 (ref), v88 (ref), v87 (copy), v14 (ref)
                if not v10:Wait(l_LocalPlayer_0) then
                    return;
                else
                    v85.ObjectText = "Witching Hour Limited";
                    v85.ActionText = "Open";
                    local l_v17_Instant_0 = v17:GetInstant("WitchingHourEventMachineEndTime", nil);
                    local v90 = true;
                    if l_v17_Instant_0 ~= nil then
                        v90 = DateTime.now().UnixTimestamp < l_v17_Instant_0;
                    end;
                    v85.Enabled = v90;
                    if v88 ~= v90 then
                        v88 = v90;
                        v87:Clean();
                        if not v90 then
                            v87:Add(v14.observeTag("WitchingHourMachineHide", function(v91) --[[ Line: 266 ]]
                                if v91:IsA("BasePart") then
                                    v91.Transparency = 1;
                                    v91.CanCollide = false;
                                    return function() --[[ Line: 271 ]]
                                        -- upvalues: v91 (copy)
                                        v91.Transparency = 0;
                                        v91.CanCollide = true;
                                    end;
                                elseif v91:IsA("SurfaceGui") then
                                    v91.Enabled = false;
                                    return function() --[[ Line: 278 ]]
                                        -- upvalues: v91 (copy)
                                        v91.Enabled = true;
                                    end;
                                else
                                    return nil;
                                end;
                            end));
                        end;
                    end;
                    return;
                end;
            end;
            v86:Add(task.spawn(function() --[[ Line: 289 ]]
                -- upvalues: v10 (ref), l_LocalPlayer_0 (ref), v86 (copy), v18 (ref), v92 (copy)
                if not v10:Wait(l_LocalPlayer_0) then
                    return;
                else
                    v86:Add(v18.Simple(1, v92));
                    task.spawn(v92);
                    return;
                end;
            end));
            v86:Add(v85.Triggered:Connect(function() --[[ Line: 299 ]]
                -- upvalues: v10 (ref), l_LocalPlayer_0 (ref), v24 (ref)
                if not v10:Get(l_LocalPlayer_0) then
                    return;
                else
                    v24:Toggle("WitchingHourMachine");
                    return;
                end;
            end));
            return function() --[[ Line: 308 ]]
                -- upvalues: v86 (copy)
                v86:Destroy();
            end;
        end);
        v14.observeTag("WitchingHourMachine", function(v93) --[[ Line: 313 ]]
            -- upvalues: v19 (ref), l_Players_0 (ref), l_LocalPlayer_0 (ref), v43 (ref), v26 (ref), l_ReplicatedStorage_0 (ref)
            local v94 = v19.new();
            for _, v96 in v93.Hitboxes:GetChildren() do
                v94:Add(v96.Touched:Connect(function(v97) --[[ Line: 317 ]]
                    -- upvalues: l_Players_0 (ref), l_LocalPlayer_0 (ref), v43 (ref), v96 (copy), v26 (ref), l_ReplicatedStorage_0 (ref)
                    if v97.Name ~= "HumanoidRootPart" then
                        return;
                    else
                        local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v97.Parent);
                        if not l_l_Players_0_PlayerFromCharacter_0 or l_l_Players_0_PlayerFromCharacter_0 ~= l_LocalPlayer_0 then
                            return;
                        else
                            if l_l_Players_0_PlayerFromCharacter_0:GetAttribute("StealingIndex") then
                                local v99, _, _ = v43:InvokeServer("WitchingHour", v96);
                                if not v99 then
                                    return;
                                else
                                    task.spawn(function() --[[ Line: 334 ]]
                                        -- upvalues: v26 (ref), l_ReplicatedStorage_0 (ref)
                                        v26:PlaySound(l_ReplicatedStorage_0.Sounds.Sfx["Fuse Machine"].Deposit);
                                    end);
                                end;
                            end;
                            return;
                        end;
                    end;
                end));
            end;
            return function() --[[ Line: 342 ]]
                -- upvalues: v94 (copy)
                v94:Destroy();
            end;
        end);
    end
};