-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local v5 = require(l_Controllers_0.InterfaceController);
local _ = require(l_Controllers_0.ShopController);
local v7 = require(l_Controllers_0.NotificationController);
local _ = require(l_Controllers_0.SoundController);
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v10 = require(l_Packages_0.Observers);
local v11 = require(l_Packages_0.Synchronizer);
local v12 = require(l_Packages_0.Timer);
local _ = require(l_Packages_0.Trove);
local v14 = require(l_Packages_0.Net);
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local v16 = require(l_Utils_0.TimeUtils);
local v17 = require(l_Utils_0.NumberUtils);
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local v19 = require(l_Datas_0.YinYangSpinWheel);
local v20 = require(l_Datas_0.Shop);
local l_Classes_0 = l_ReplicatedStorage_0:WaitForChild("Classes");
local v22 = require(script.YinYangSpinWheel);
local v23 = require(l_Classes_0.AnimatedButton);
local l_Shared_0 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v25 = require(l_Shared_0.Marketplace);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_YinYangWheel_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("YinYangWheel").YinYangWheel;
local v28 = nil;
local v29 = false;
local v30 = v14:RemoteEvent("ShopService/Purchase");
local v31 = v14:RemoteEvent("YinYangEventService/Spin");
local _ = v14:RemoteFunction("YinYangEventService/RequestBuy");
local v33 = false;
local _ = {};
local v35 = {};
local function _() --[[ Line: 60 ]] --[[ Name: IsEnabled ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    return l_ReplicatedStorage_0:GetAttribute("YinYangEvent");
end;
local function _() --[[ Line: 64 ]] --[[ Name: GetIntervalInSeconds ]]
    local l_wday_0 = os.date("!*t", workspace:GetServerTimeNow()).wday;
    if l_wday_0 == 1 or l_wday_0 == 7 then
        return 3600;
    else
        return 10800;
    end;
end;
local function _() --[[ Line: 69 ]] --[[ Name: GetIntervalToEnable ]]
    local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
    if l_workspace_ServerTimeNow_0 < 1755961200 then
        return 1755961200 - l_workspace_ServerTimeNow_0;
    else
        local l_wday_1 = os.date("!*t", workspace:GetServerTimeNow()).wday;
        local v41 = (not (l_wday_1 ~= 1) or l_wday_1 == 7) and 3600 or 10800;
        return v41 - l_workspace_ServerTimeNow_0 % v41;
    end;
end;
local function _() --[[ Line: 79 ]] --[[ Name: GetIntervalToDisable ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    if not l_ReplicatedStorage_0:GetAttribute("YinYangEvent") then
        return 0;
    else
        return (math.clamp((l_ReplicatedStorage_0:GetAttribute("YinYangEventLastTime") or 0) + 900 - os.time(), 0, 1e999));
    end;
end;
local function v64(v44, v45) --[[ Line: 87 ]] --[[ Name: ResultAnimation ]]
    -- upvalues: v11 (copy), l_LocalPlayer_0 (copy), v33 (ref), l_YinYangWheel_0 (copy), v29 (ref), l_RunService_0 (copy), l_TweenService_0 (copy), v19 (copy), v20 (copy), v17 (copy), v7 (copy)
    local v46 = v11:Wait(l_LocalPlayer_0);
    if v33 then
        return;
    else
        v33 = true;
        local l_Wheel_0 = l_YinYangWheel_0.Wheel;
        local l_Spinning_0 = l_Wheel_0:FindFirstChild("Spinning");
        local v49 = v29 and 1 or 0.8;
        if l_Spinning_0 then
            l_Spinning_0.Looped = true;
            l_Spinning_0.Volume = v49;
            l_Spinning_0:Play();
        end;
        local v50 = (v44 - 1) * -60 - (math.random() - 0.5) * 0.7 * 60;
        local v51 = v50 + (v29 and 1 or 9) * 360;
        local v52 = v29 and 0.5 or 5;
        local v53 = nil;
        local v55 = l_RunService_0.PostSimulation:Connect(function() --[[ Line: 112 ]]
            -- upvalues: l_Wheel_0 (copy), v53 (ref), l_YinYangWheel_0 (ref), l_TweenService_0 (ref)
            debug.profilebegin("YinYangEventController:ResultAnimation");
            local v54 = (l_Wheel_0.Rotation + 30) / 60 // 1;
            if v53 ~= v54 then
                v53 = v54;
                l_YinYangWheel_0.Tick.Rotation = -40;
                l_TweenService_0:Create(l_YinYangWheel_0.Tick, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Rotation = 0
                }):Play();
            end;
            debug.profileend();
        end);
        local v56 = TweenInfo.new(v52, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        local v57 = l_TweenService_0:Create(l_Wheel_0, v56, {
            Rotation = v51
        });
        local _ = nil;
        if l_Spinning_0 then
            l_TweenService_0:Create(l_Spinning_0, TweenInfo.new(v52, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
        end;
        v57:Play();
        v57.Completed:Wait();
        v55:Disconnect();
        l_Wheel_0.Rotation = v50;
        if l_Spinning_0 then
            l_Spinning_0:Stop();
            l_Spinning_0.Volume = v49;
        end;
        local v59 = v45 == true and v19.AltRewards[v44] or v19.Rewards[v44];
        local v60 = "";
        if v59.Type == "Cash-Pack" then
            local v61 = v20[v59.Index];
            if not v20 then
                return false;
            else
                local v62 = v61.Value or 0;
                local v63 = v46:Get("Rebirth") or 0;
                if v63 > 0 then
                    v62 = v62 * (v63 <= 1 and 1.5 or v63);
                end;
                v60 = ("$%*"):format((v17:ToString(v62, 2)));
            end;
        else
            v60 = v59.Display;
        end;
        v7:Success((("You received %*!"):format(v60)));
        v33 = false;
        return;
    end;
end;
v35.SetupYinYangWheel = function(_) --[[ Line: 167 ]] --[[ Name: SetupYinYangWheel ]]
    -- upvalues: v28 (ref), v5 (copy), l_YinYangWheel_0 (copy), v11 (copy), l_LocalPlayer_0 (copy), v19 (copy), v20 (copy), v17 (copy), v25 (copy), v33 (ref), v23 (copy), v29 (ref), v30 (copy), v31 (copy), l_ReplicatedStorage_0 (copy), v16 (copy), v64 (copy), v12 (copy), v10 (copy), v22 (copy)
    v28 = v5:Register("YinYangWheel", l_YinYangWheel_0, "TopQuint");
    v28:AttachCloseButton(l_YinYangWheel_0.Close);
    v28:Close();
    local v66 = v11:Wait(l_LocalPlayer_0);
    local function v89() --[[ Line: 175 ]] --[[ Name: setup ]]
        -- upvalues: l_YinYangWheel_0 (ref), v19 (ref), v66 (copy), v20 (ref), v17 (ref), v25 (ref)
        local l_Wheel_1 = l_YinYangWheel_0.Wheel;
        local l_Items_0 = l_Wheel_1.Items;
        local l_Names_0 = l_Wheel_1.Names;
        local l_Odds_0 = l_Wheel_1.Odds;
        local v71 = {};
        for v72 = 1, #v19.Rewards do
            local v73 = v19.Rewards[v72];
            if v73 then
                if v73.Type == "Item" and v66:Get((("Items.%*"):format(v73.Index))) then
                    v73 = v19.AltRewards[v72];
                end;
                v71[v72] = v73.Weight;
            end;
        end;
        local v74 = 0;
        for _, v76 in v71 do
            v74 = v74 + v76;
        end;
        v71[5] = v71[5] + (100 - v74);
        for v77 = 1, #v19.Rewards do
            local v78 = v19.Rewards[v77];
            if v78 then
                if v78.Type == "Item" and v66:Get((("Items.%*"):format(v78.Index))) then
                    v78 = v19.AltRewards[v77];
                end;
                local l_l_Items_0_FirstChild_0 = l_Items_0:FindFirstChild(v77);
                local l_l_Names_0_FirstChild_0 = l_Names_0:FindFirstChild(v77);
                local l_l_Odds_0_FirstChild_0 = l_Odds_0:FindFirstChild(v77);
                local v82 = "";
                local v83 = "";
                local v84 = "";
                if v78.Type == "Cash-Pack" then
                    local l_Value_0 = v20[v78.Index].Value;
                    local v86 = v66:Get("Rebirth") or 0;
                    if v86 > 0 then
                        l_Value_0 = l_Value_0 * (v86 <= 1 and 1.5 or v86);
                    end;
                    v83 = ("$%*"):format((v17:ToString(l_Value_0, 2)));
                    local l_Index_0 = v78.Index;
                    v82 = v25:GetProductInfo(l_Index_0, "Product").Icon;
                else
                    v82 = v78.Icon;
                end;
                local l_Display_0 = v78.Display;
                v83 = v83 == "" and l_Display_0 or v83;
                v84 = ("%*%%"):format(math.floor(v71[v77] * 100) / 100);
                l_l_Items_0_FirstChild_0.Image = v82;
                l_l_Names_0_FirstChild_0.Text = v83;
                l_l_Odds_0_FirstChild_0.Text = v84;
            end;
        end;
    end;
    v89();
    v66:OnDictionaryInserted("Items", function(_, v91) --[[ Line: 250 ]]
        -- upvalues: v19 (ref), v33 (ref), v89 (copy)
        local v92 = false;
        for v93 = 1, #v19.Rewards do
            local v94 = v19.Rewards[v93];
            if v94.Type == "Item" and v91 == v94.Index then
                v92 = true;
                break;
            end;
        end;
        if v92 then
            while v33 do
                task.wait();
            end;
            v89();
        end;
    end);
    local l_Toggle_0 = l_YinYangWheel_0.FastSpin.Toggle;
    local v96 = v23.new(l_Toggle_0);
    v96:Animate();
    local function _() --[[ Line: 272 ]] --[[ Name: updateFastSpin ]]
        -- upvalues: l_Toggle_0 (copy), v29 (ref)
        l_Toggle_0.Checkmark.Visible = v29;
    end;
    v96.OnActivated:Connect(function() --[[ Line: 276 ]]
        -- upvalues: v29 (ref), l_Toggle_0 (copy)
        v29 = not v29;
        l_Toggle_0.Checkmark.Visible = v29;
    end);
    l_Toggle_0.Checkmark.Visible = v29;
    for _, v99 in l_YinYangWheel_0.Buttons:GetChildren() do
        if v99:IsA("ImageButton") and v99.Name ~= "Spin" then
            local v100 = v23.new(v99);
            v100:Animate();
            v100.OnActivated:Connect(function() --[[ Line: 288 ]]
                -- upvalues: v30 (ref), v99 (copy)
                v30:FireServer(v99:GetAttribute("ProductId"));
            end);
            local l_v25_ProductInfo_0 = v25:GetProductInfo(v99:GetAttribute("ProductId"), "Product");
            v99.RbxAmount.Text = l_v25_ProductInfo_0.PriceInRobux;
        end;
    end;
    local l_Spin_0 = l_YinYangWheel_0.Buttons.Spin;
    local v103 = v23.new(l_Spin_0);
    v103:Animate();
    v103.OnActivated:Connect(function() --[[ Line: 299 ]]
        -- upvalues: v33 (ref), v31 (ref)
        if v33 == true then
            return;
        else
            v31:FireServer();
            return;
        end;
    end);
    local function v121() --[[ Line: 305 ]] --[[ Name: mainLoop ]]
        -- upvalues: l_ReplicatedStorage_0 (ref), v66 (copy), l_Spin_0 (copy), v16 (ref), l_YinYangWheel_0 (ref)
        local v104 = 0;
        if l_ReplicatedStorage_0:GetAttribute("YinYangEvent") then
            if v66:Get("YinYangSpinWheel.LastFreeClaimed") ~= l_ReplicatedStorage_0:GetAttribute("YinYangEventLastTime") then
                v104 = v104 + 1;
                l_Spin_0.Main.Timer.Text = "SPIN NOW";
            else
                local l_Timer_0 = l_Spin_0.Main.Timer;
                local v106 = "Free Spin in %*";
                local l_v16_0 = v16;
                local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
                local v109;
                if l_workspace_ServerTimeNow_1 < 1755961200 then
                    v109 = 1755961200 - l_workspace_ServerTimeNow_1;
                else
                    local l_wday_2 = os.date("!*t", workspace:GetServerTimeNow()).wday;
                    local v111 = (not (l_wday_2 ~= 1) or l_wday_2 == 7) and 3600 or 10800;
                    v109 = v111 - l_workspace_ServerTimeNow_1 % v111;
                end;
                l_Timer_0.Text = v106:format((l_v16_0:D(v109)));
            end;
        else
            local l_Timer_1 = l_Spin_0.Main.Timer;
            local v113 = "Free Spin in %*";
            local l_v16_1 = v16;
            local l_workspace_ServerTimeNow_2 = workspace:GetServerTimeNow();
            local v116;
            if l_workspace_ServerTimeNow_2 < 1755961200 then
                v116 = 1755961200 - l_workspace_ServerTimeNow_2;
            else
                local l_wday_3 = os.date("!*t", workspace:GetServerTimeNow()).wday;
                local v118 = (not (l_wday_3 ~= 1) or l_wday_3 == 7) and 3600 or 10800;
                v116 = v118 - l_workspace_ServerTimeNow_2 % v118;
            end;
            l_Timer_1.Text = v113:format((l_v16_1:D(v116)));
        end;
        v104 = v104 + v66:Get("YinYangSpinWheel.Spins");
        l_Spin_0.Main.Spins.Text = v104 > 1 and ("Spins (%*)"):format(v104) or ("Spin (%*)"):format(v104);
        l_Spin_0.Main.UIGradient.Enabled = v104 <= 0;
        local v119 = workspace:GetServerTimeNow() - v66:Get("YinYangSpinWheel.LastDailyDiscount") >= 86400;
        l_YinYangWheel_0.Buttons.Buy1.Visible = not v119;
        l_YinYangWheel_0.Buttons.Buy1Discount.Visible = v119;
        local v120 = v66:Get("YinYangSpinWheel.PaidSpins.x3") >= 5;
        l_YinYangWheel_0.Buttons.Buy10.Visible = v120;
        l_YinYangWheel_0.Buttons.Buy3.Visible = not v120;
    end;
    v31.OnClientEvent:Connect(function(v122, v123) --[[ Line: 341 ]]
        -- upvalues: v121 (copy), v64 (ref)
        task.spawn(v121);
        v64(v122, v123);
    end);
    v12.Simple(1, v121);
    v10.observeTag("YinYangSpinWheel", function(v124) --[[ Line: 348 ]]
        -- upvalues: v22 (ref)
        local v125 = v22.new(v124);
        return function() --[[ Line: 350 ]]
            -- upvalues: v125 (copy)
            v125:Destroy();
        end;
    end);
end;
v35.Start = function(v126) --[[ Line: 357 ]] --[[ Name: Start ]]
    v126:SetupYinYangWheel();
end;
return v35;