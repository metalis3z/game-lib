-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Sounds);
local l_UpdatelogPresets_0 = l_ReplicatedStorage_0.Assets.UI.UpdatelogPresets;
local l_Changelogs_0 = l_ReplicatedStorage_0.Assets.Changelogs;
local v9 = TweenInfo.new(0.2);
local l_l_Changelogs_0_Attribute_0 = l_Changelogs_0:GetAttribute("LatestLog");
return {
    Start = function(_) --[[ Line: 24 ]] --[[ Name: Start ]]
        -- upvalues: l_Changelogs_0 (copy), l_l_Changelogs_0_Attribute_0 (copy), l_LocalPlayer_0 (copy), l_UpdatelogPresets_0 (copy), l_TweenService_0 (copy), v9 (copy), v6 (copy), v5 (copy), l_PlayerGui_0 (copy)
        task.spawn(function() --[[ Line: 26 ]]
            -- upvalues: l_Changelogs_0 (ref), l_l_Changelogs_0_Attribute_0 (ref), l_LocalPlayer_0 (ref), l_UpdatelogPresets_0 (ref), l_TweenService_0 (ref), v9 (ref), v6 (ref), v5 (ref), l_PlayerGui_0 (ref)
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 28 ]]
                -- upvalues: l_Changelogs_0 (ref), l_l_Changelogs_0_Attribute_0 (ref)
                return require(l_Changelogs_0:FindFirstChild(l_l_Changelogs_0_Attribute_0));
            end);
            if not l_status_0 then
                warn((("[UpdateLog]: Failed to get the changelog: %*"):format(l_l_Changelogs_0_Attribute_0)));
                return;
            elseif l_LocalPlayer_0:WaitForChild("PlayerData").Misc.LastSeenLog.Value == l_l_Changelogs_0_Attribute_0 then
                return;
            else
                local v14 = script.UpdateScreen:Clone();
                local v15 = l_UpdatelogPresets_0.UpdatePreset:Clone();
                v15.MainInfo.TitleMeta.Date.Text = l_result_0.TitleMeta.Text.Date;
                v15.MainInfo.TitleMeta.Title.Text = l_result_0.TitleMeta.Text.Title;
                v15.MainInfo.IntroImage.Image = l_result_0.TitleMeta.Image.Title;
                v15.Backdrop.Image = l_result_0.TitleMeta.Image.Backdrop;
                local v16 = 0;
                for v17 = 1, #l_result_0.Notes do
                    local v18 = l_result_0.Notes[v17];
                    local v19 = l_UpdatelogPresets_0.Components.Header:Clone();
                    v19.Text = v18.Header;
                    v19.LayoutOrder = v16;
                    v19.Parent = v15.Notes;
                    local v20 = l_UpdatelogPresets_0.Components.Seperator:Clone();
                    v20.LayoutOrder = v16 + 1;
                    v20.Parent = v15.Notes;
                    local v21 = l_UpdatelogPresets_0.Components.TextPreset:Clone();
                    v21.Main.Text = v18.Body;
                    v21.Size = v18.NoteSize or UDim2.fromScale(0.9, 0.25);
                    v21.LayoutOrder = v16 + 2;
                    v21.Parent = v15.Notes;
                    v16 = v16 + 3;
                end;
                local l_Exit_0 = v14.UpdateContainer.Exit;
                l_Exit_0.MouseEnter:Connect(function() --[[ Line: 79 ]]
                    -- upvalues: l_TweenService_0 (ref), l_Exit_0 (copy), v9 (ref), v6 (ref)
                    l_TweenService_0:Create(l_Exit_0, v9, {
                        Size = UDim2.fromScale(0.175, 0.175)
                    }):Play();
                    v6:Play("hover");
                end);
                l_Exit_0.MouseLeave:Connect(function() --[[ Line: 84 ]]
                    -- upvalues: l_TweenService_0 (ref), l_Exit_0 (copy), v9 (ref), v6 (ref)
                    l_TweenService_0:Create(l_Exit_0, v9, {
                        Size = UDim2.fromScale(0.15, 0.15)
                    }):Play();
                    v6:Play("hoverEnd");
                end);
                l_Exit_0.MouseButton1Click:Once(function() --[[ Line: 89 ]]
                    -- upvalues: v5 (ref), v6 (ref), l_TweenService_0 (ref), v14 (copy)
                    v5:FireServerConnection("UpdateLogToLatest", "REMOTE_EVENT");
                    v6:Play("select");
                    l_TweenService_0:Create(v14, TweenInfo.new(0.25), {
                        Size = UDim2.new(1, -20, 0, 0)
                    }):Play();
                    task.delay(0.25, function() --[[ Line: 95 ]]
                        -- upvalues: v14 (ref)
                        v14.Visible = false;
                    end);
                end);
                v15.Parent = v14.UpdateContainer.Canvas.Contents;
                v14.Parent = l_PlayerGui_0.MainUI;
                return;
            end;
        end);
    end
};