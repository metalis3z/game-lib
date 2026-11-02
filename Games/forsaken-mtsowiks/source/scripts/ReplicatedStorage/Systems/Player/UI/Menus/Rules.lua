-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local v3 = require(game.ReplicatedStorage.Initializer);
local v4 = require(l_ReplicatedStorage_0.Modules.Sounds);
local _ = require(script.Parent.Parent.Misc.UpdateLog);
local _ = l_Players_0.LocalPlayer.PlayerGui;
local l_UpdatelogPresets_0 = l_ReplicatedStorage_0.Assets.UI.UpdatelogPresets;
local v8 = TweenInfo.new(0.2);
local v9 = {};
v9.Start = function(_) --[[ Line: 21 ]] --[[ Name: Start ]]
    -- upvalues: v9 (copy), v3 (copy), l_ReplicatedStorage_0 (copy), l_UpdatelogPresets_0 (copy), l_TweenService_0 (copy), v8 (copy), v4 (copy)
    v9.RulesMenu = v3.PlayerSystems.SidebarHandler:CreateSidebarMenu("Rules", script.RulesScreen);
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 25 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref)
        return require(l_ReplicatedStorage_0.Assets.Rules);
    end);
    if not l_status_0 then
        warn((("[%*]: Failed to get the rules due to: %*"):format(script, l_result_0)));
        return;
    else
        local v13 = 1;
        for v14 = 1, #l_result_0 do
            local v15 = l_result_0[v14];
            local v16 = l_UpdatelogPresets_0.Components.Header:Clone();
            v16.Text = v15.Header;
            v16.LayoutOrder = v13;
            v16.Parent = v9.RulesMenu.Menu.RulesContainer.Contents;
            local v17 = l_UpdatelogPresets_0.Components.Seperator:Clone();
            v17.LayoutOrder = v13 + 1;
            v17.Parent = v9.RulesMenu.Menu.RulesContainer.Contents;
            local v18 = l_UpdatelogPresets_0.Components.TextPreset:Clone();
            v18.Main.Text = v15.Body;
            v18.AutomaticSize = Enum.AutomaticSize.None;
            v18.Size = v15.NoteSize or UDim2.fromScale(0.9, 0.5);
            v18.LayoutOrder = v13 + 2;
            v18.Parent = v9.RulesMenu.Menu.RulesContainer.Contents;
            v13 = v13 + 3;
        end;
        local l_Exit_0 = v9.RulesMenu.Menu.RulesContainer.Exit;
        l_Exit_0.MouseEnter:Connect(function() --[[ Line: 61 ]]
            -- upvalues: l_TweenService_0 (ref), l_Exit_0 (copy), v8 (ref), v4 (ref)
            l_TweenService_0:Create(l_Exit_0, v8, {
                Size = UDim2.fromScale(0.175, 0.175)
            }):Play();
            v4:Play("hover");
        end);
        l_Exit_0.MouseLeave:Connect(function() --[[ Line: 66 ]]
            -- upvalues: l_TweenService_0 (ref), l_Exit_0 (copy), v8 (ref), v4 (ref)
            l_TweenService_0:Create(l_Exit_0, v8, {
                Size = UDim2.fromScale(0.15, 0.15)
            }):Play();
            v4:Play("hoverEnd");
        end);
        l_Exit_0.MouseButton1Click:Connect(function() --[[ Line: 71 ]]
            -- upvalues: v9 (ref)
            v9.RulesMenu:ToggleMenu(false);
        end);
        return;
    end;
end;
return v9;