-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_GuiService_0 = game:GetService("GuiService");
local _ = game:GetService("RunService");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local v6 = {
    UI = nil
};
local function _(v7, v8) --[[ Line: 13 ]] --[[ Name: bindCallbackToSettingChanged ]]
    v7.Changed:Connect(v8);
    v8(v7.Value);
end;
v6.GetComponent = function(v10, v11) --[[ Line: 18 ]] --[[ Name: GetComponent ]]
    local l_FirstChild_0 = v10.UI:FindFirstChild(v11);
    if l_FirstChild_0 then
        return l_FirstChild_0;
    else
        error((("%* does not exist in MobileUI"):format(v11)));
        return;
    end;
end;
v6.Start = function(v13) --[[ Line: 28 ]] --[[ Name: Start ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), l_LocalPlayer_0 (copy), l_GuiService_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy)
    task.spawn(function() --[[ Line: 29 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref), l_LocalPlayer_0 (ref), v13 (copy), l_GuiService_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref)
        local l_SmoothShiftLock_0 = require(l_ReplicatedStorage_0:WaitForChild("Systems"):WaitForChild("Player"):WaitForChild("Game"):WaitForChild("SmoothShiftLock"));
        local l_Device_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("Device"));
        local v16 = nil;
        while not v16 do
            v16 = l_Device_0 and l_Device_0:GetPlayerDevice();
            task.wait();
        end;
        if v16 == "PC" then
            return;
        else
            local l_MainUI_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("MainUI");
            local v18 = script.MobileUI:Clone();
            v18.Parent = l_MainUI_0;
            v13.UI = v18;
            local l_Settings_0 = l_LocalPlayer_0:WaitForChild("PlayerData"):WaitForChild("Settings");
            local l_Crosshair_0 = v18:WaitForChild("Crosshair");
            local _ = l_MainUI_0.AbsoluteSize;
            local l_CrosshairEnabled_0 = l_Settings_0.Customization.CrosshairEnabled;
            local function v24(v23) --[[ Line: 55 ]]
                -- upvalues: l_Crosshair_0 (copy)
                l_Crosshair_0.Visible = v23;
            end;
            l_CrosshairEnabled_0.Changed:Connect(v24);
            v24(l_CrosshairEnabled_0.Value);
            l_CrosshairEnabled_0 = l_Settings_0.Customization.CrosshairID;
            v24 = function(v25) --[[ Line: 59 ]]
                -- upvalues: l_Crosshair_0 (copy)
                l_Crosshair_0.Image = ("rbxthumb://type=Asset&id=%*&w=420&h=420"):format((tostring(v25):gsub("%D", "")));
            end;
            l_CrosshairEnabled_0.Changed:Connect(v24);
            v24(l_CrosshairEnabled_0.Value);
            task.spawn(function() --[[ Line: 66 ]]
                -- upvalues: l_SmoothShiftLock_0 (copy), l_Crosshair_0 (copy), l_GuiService_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref)
                while task.wait() do
                    local l_CurrentCamera_0 = workspace.CurrentCamera;
                    local v27 = l_SmoothShiftLock_0:IsEnabled() or (l_CurrentCamera_0.Focus.Position - l_CurrentCamera_0.CFrame.Position).Magnitude < 1;
                    l_Crosshair_0.AnchorPoint = Vector2.new(0.5, 0.5);
                    if v27 then
                        local l_l_GuiService_0_GuiInset_0 = l_GuiService_0:GetGuiInset();
                        local v29 = l_CurrentCamera_0.ViewportSize / 2;
                        l_Crosshair_0.Position = UDim2.new(0, v29.X, 0, v29.Y - l_l_GuiService_0_GuiInset_0.Y);
                    else
                        l_Crosshair_0.Position = UDim2.new(0, l_l_LocalPlayer_0_Mouse_0.X, 0, l_l_LocalPlayer_0_Mouse_0.Y);
                    end;
                end;
            end);
            return;
        end;
    end);
end;
return v6;