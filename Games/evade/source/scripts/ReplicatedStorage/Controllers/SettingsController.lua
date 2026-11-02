-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v4 = require(l_ReplicatedStorage_0.Packages.TopbarPlus);
local v5 = require(l_ReplicatedStorage_0.Packages.Net);
local v6 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v7 = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local v8 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local v9 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v10 = require(l_ReplicatedStorage_0.Shared.Index);
local v11 = require(l_ReplicatedStorage_0.Datas.Index);
local v12 = require(l_ReplicatedStorage_0.Packages.Trove);
local v13 = v5:RemoteFunction("SettingsService/ToggleSetting");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local v16 = v4.new():setImage(110481567543062, "Selected"):setImage(78403024093069, "Deselected"):setOrder(1);
local v17 = {
    Music = 1, 
    ["Sound Effects"] = 2, 
    VFX = 3, 
    ["Chat Tips"] = 4, 
    ["Base Skin"] = 5
};
local v18 = nil;
local l_Settings_0 = l_PlayerGui_0:WaitForChild("Settings").Settings;
local l_ScrollingFrame_0 = l_Settings_0.Content.ScrollingFrame;
local l_Template_0 = l_ScrollingFrame_0.Template;
local l_TemplateBaseSkin_0 = l_ScrollingFrame_0.TemplateBaseSkin;
local l_Close_0 = l_Settings_0.Header.Close;
local v24 = v12.new();
local v25 = {};
local _ = {};
local _ = function() --[[ Line: 56 ]] --[[ Name: GetMutationNames ]]
    -- upvalues: v11 (copy)
    local v27 = {
        "Normal"
    };
    for v28, _ in v11 do
        table.insert(v27, v28);
    end;
    return v27;
end;
local function v78(v31) --[[ Line: 64 ]] --[[ Name: ConstructSettings ]]
    -- upvalues: v3 (copy), l_LocalPlayer_0 (copy), v24 (copy), l_TemplateBaseSkin_0 (copy), l_ScrollingFrame_0 (copy), v11 (copy), v10 (copy), v6 (copy), v13 (copy), v7 (copy), v9 (copy), v17 (copy), l_Template_0 (copy)
    local v32 = v3:Get(l_LocalPlayer_0);
    v24:Clean();
    for v33, v34 in v31 do
        if v33 == "Base Skin" then
            local v35 = v24:Clone(l_TemplateBaseSkin_0);
            v35.Name = v33;
            v35.Function.Text = v33;
            v35.Button.DropDown.AnchorPoint = Vector2.new(0.5, 0);
            v35.Button.DropDown.Position = UDim2.fromScale(0.5, 1.2);
            v35.Button.DropDown.Size = UDim2.fromScale(1.221, 0);
            v35.Button.DropDown.AutomaticSize = Enum.AutomaticSize.Y;
            local v36 = {};
            local v37 = {};
            local function _(v38) --[[ Line: 86 ]] --[[ Name: calculateCanvasSize ]]
                -- upvalues: l_ScrollingFrame_0 (ref), v35 (copy), v36 (copy)
                local l_Y_0 = l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y;
                local v40 = if v35.Button.DropDown.Visible then (#v36 + 1) * ((v38 or v35.Button.AbsoluteSize).Y + 8) else 0;
                return UDim2.fromOffset(0, l_Y_0 + v40);
            end;
            local v42 = {
                "Normal"
            };
            for v43, _ in v11 do
                table.insert(v42, v43);
            end;
            for _, v46 in v42 do
                if v46 ~= v34 then
                    local v47 = v11[v46];
                    local v48 = v46 == "Normal" or v10:IsComplete(l_LocalPlayer_0, v46) or v32 and v32:Get((("UnlockedBaseSkins.%*"):format(v46)));
                    if v48 or v47.ShowInSettings ~= false then
                        local v49 = v24:Clone(v35.Button.DropDown.Template);
                        table.insert(v36, v49);
                        v49.Name = v46;
                        v49.Text.Text = v47 and v47.DisplayText or v46;
                        v49.Locked.Visible = not v48;
                        v49.BackgroundColor3 = v46 ~= "Normal" and v47.MainColor or Color3.new(0.490196, 0.435294, 0.435294);
                        v49.UIStroke.Color = v46 ~= "Normal" and (if v47.Palettes then v47.Palettes[1][2] else v47.MainColor) or Color3.new(0.490196, 0.435294, 0.435294);
                        v49.Text.UIStroke.Color = v46 ~= "Normal" and (if v47.Palettes then v47.Palettes[1][2] else v47.MainColor) or Color3.new(0.490196, 0.435294, 0.435294);
                        if v48 then
                            local v50 = v6.new(v49);
                            v24:Add(v50);
                            v50:Animate();
                            v24:Add(v50.OnActivated:Connect(function() --[[ Line: 120 ]]
                                -- upvalues: l_ScrollingFrame_0 (ref), v35 (copy), v36 (copy), v13 (ref), v33 (copy), v46 (copy), v7 (ref), v9 (ref)
                                l_ScrollingFrame_0.CanvasSize = UDim2.new(0, 0, 0, 0);
                                local l_DropDown_0 = v35.Button.DropDown;
                                if l_DropDown_0.Visible then
                                    l_DropDown_0.Visible = not l_DropDown_0.Visible;
                                    v35.Button.Polygon.Rotation = l_DropDown_0.Visible and 180 or 0;
                                    local l_l_ScrollingFrame_0_0 = l_ScrollingFrame_0;
                                    local l_Y_1 = l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y;
                                    local v54 = if v35.Button.DropDown.Visible then (#v36 + 1) * (v35.Button.AbsoluteSize.Y + 8) else 0;
                                    l_l_ScrollingFrame_0_0.CanvasSize = UDim2.fromOffset(0, l_Y_1 + v54);
                                    l_ScrollingFrame_0.CanvasPosition = l_DropDown_0.Visible and Vector2.new(0, l_ScrollingFrame_0.AbsoluteCanvasSize.Y - l_ScrollingFrame_0.AbsoluteSize.Y) or Vector2.new(0, 0);
                                end;
                                local v55, v56 = v13:InvokeServer(v33, v46);
                                if not v55 then
                                    v7:Error(v56);
                                    v9:PlaySound("Sounds.Sfx.Error");
                                end;
                            end));
                            table.insert(v37, v50);
                        end;
                        v49.LayoutOrder = v46 ~= "Normal" and v11[v46].Order or 1;
                        v49.Visible = true;
                        v49.Parent = v35.Button.DropDown;
                    end;
                end;
            end;
            local function v66() --[[ Line: 147 ]] --[[ Name: updateScaling ]]
                -- upvalues: v35 (copy), v36 (copy), v37 (copy), l_ScrollingFrame_0 (ref)
                local l_AbsoluteSize_0 = v35.Button.AbsoluteSize;
                local v58 = UDim2.fromOffset(l_AbsoluteSize_0.X, l_AbsoluteSize_0.Y);
                for _, v60 in v36 do
                    v60.Size = v58;
                end;
                for _, v62 in v37 do
                    v62.DefaultSize = v58;
                end;
                local l_l_ScrollingFrame_0_1 = l_ScrollingFrame_0;
                local l_Y_2 = l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y;
                local v65 = if v35.Button.DropDown.Visible then (#v36 + 1) * ((l_AbsoluteSize_0 or v35.Button.AbsoluteSize).Y + 8) else 0;
                l_l_ScrollingFrame_0_1.CanvasSize = UDim2.fromOffset(0, l_Y_2 + v65);
            end;
            v24:Add(v35.Button:GetPropertyChangedSignal("AbsoluteSize"):Connect(v66));
            v24:Add(v35.Button.DropDown:GetPropertyChangedSignal("Visible"):Connect(v66));
            v24:Add(task.spawn(v66));
            local v67 = v11[v34];
            local l_Button_0 = v35.Button;
            l_Button_0.Text.Text = v67 and v67.DisplayText or v34;
            l_Button_0.BackgroundColor3 = v34 ~= "Normal" and v67 and v67.MainColor or Color3.new(0.490196, 0.435294, 0.435294);
            l_Button_0.UIStroke.Color = v34 ~= "Normal" and v67 and (if v67.Palettes then v67.Palettes[1][1] else v67.MainColor) or Color3.new(0.490196, 0.435294, 0.435294);
            v42 = v6.new(l_Button_0);
            v24:Add(v42);
            v24:Add(v42.OnActivated:Connect(function() --[[ Line: 176 ]]
                -- upvalues: l_Button_0 (copy), l_ScrollingFrame_0 (ref), v35 (copy), v36 (copy)
                local l_DropDown_1 = l_Button_0.DropDown;
                l_DropDown_1.Visible = not l_DropDown_1.Visible;
                l_Button_0.Polygon.Rotation = l_DropDown_1.Visible and 180 or 0;
                local l_l_ScrollingFrame_0_2 = l_ScrollingFrame_0;
                local l_Y_3 = l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y;
                local v72 = if v35.Button.DropDown.Visible then (#v36 + 1) * (v35.Button.AbsoluteSize.Y + 8) else 0;
                l_l_ScrollingFrame_0_2.CanvasSize = UDim2.fromOffset(0, l_Y_3 + v72);
                l_ScrollingFrame_0.CanvasPosition = l_DropDown_1.Visible and Vector2.new(0, l_ScrollingFrame_0.AbsoluteCanvasSize.Y - l_ScrollingFrame_0.AbsoluteSize.Y) or Vector2.new(0, 0);
            end));
            v35.LayoutOrder = v17[v33];
            v35.Visible = true;
            v35.Parent = l_ScrollingFrame_0;
        else
            local v73 = v24:Clone(l_Template_0);
            v73.Name = v33;
            v73.Function.Text = v33;
            local l_Button_1 = v73.Buttons.Button;
            l_Button_1.Text.Text = v34 and "On" or "Off";
            l_Button_1.BackgroundColor3 = v34 and Color3.new(0.0470588, 0.466667, 0.235294) or Color3.new(0.490196, 0.435294, 0.435294);
            l_Button_1.UIStroke.Color = v34 and Color3.new(0.00784314, 0.219608, 0) or Color3.new(0.403922, 0.356863, 0.356863);
            l_Button_1.Text.UIStroke.Color = v34 and Color3.new(0.00784314, 0.219608, 0) or Color3.new(0.403922, 0.356863, 0.356863);
            local v75 = v6.new(l_Button_1);
            v24:Add(v75);
            v75:Animate();
            v24:Add(v75.OnActivated:Connect(function() --[[ Line: 204 ]]
                -- upvalues: v13 (ref), v33 (copy), v7 (ref), v9 (ref)
                local v76, v77 = v13:InvokeServer(v33);
                if not v76 then
                    v7:Error(v77);
                    v9:PlaySound("Sounds.Sfx.Error");
                end;
            end));
            v73.LayoutOrder = v17[v33];
            v73.Visible = true;
            v73.Parent = l_ScrollingFrame_0;
        end;
    end;
end;
v25.Start = function(_) --[[ Line: 218 ]] --[[ Name: Start ]]
    -- upvalues: v18 (ref), v8 (copy), l_Settings_0 (copy), l_Close_0 (copy), v16 (copy), v3 (copy), l_LocalPlayer_0 (copy), v78 (copy)
    v18 = v8:Register("Settings", l_Settings_0, "TopQuint");
    v18:AttachCloseButton(l_Close_0);
    v18:Close();
    v16.selected:Connect(function() --[[ Line: 225 ]]
        -- upvalues: v8 (ref)
        v8:SetState("Settings", true);
    end);
    v16.deselected:Connect(function() --[[ Line: 229 ]]
        -- upvalues: v8 (ref)
        v8:SetState("Settings", false);
    end);
    v18.OnOpen:Connect(function() --[[ Line: 233 ]]
        -- upvalues: v16 (ref)
        v16:select();
    end);
    v18.OnClose:Connect(function() --[[ Line: 237 ]]
        -- upvalues: v16 (ref)
        v16:deselect();
    end);
    v3:WaitAndCall(l_LocalPlayer_0, function(v80) --[[ Line: 241 ]]
        -- upvalues: v78 (ref)
        local v81 = v80:Get("Settings");
        v80:OnDictionaryInserted("UnlockedBaseSkins", function() --[[ Line: 244 ]]
            -- upvalues: v78 (ref), v80 (copy)
            task.spawn(v78, v80:Get("Settings"));
        end);
        for v82, _ in v81 do
            v80:OnChanged(("Settings.%*"):format(v82), function(_) --[[ Line: 249 ]]
                -- upvalues: v78 (ref), v80 (copy)
                task.spawn(v78, v80:Get("Settings"));
            end);
        end;
        task.spawn(v78, v80:Get("Settings"));
    end);
end;
return v25;