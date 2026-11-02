-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 3 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local l_Stats_0 = game.Players.LocalPlayer:WaitForChild("PlayerData"):WaitForChild("Stats");
    v0.StatsMenu = require(game.ReplicatedStorage.Initializer).PlayerSystems.SidebarHandler:CreateSidebarMenu("Stats", script.StatsScreen);
    local l_Contents_0 = v0.StatsMenu.Menu.StatsContainer.Contents;
    local l_Templates_0 = script.Templates;
    local function v5(v6, v7) --[[ Line: 22 ]] --[[ Name: createStatUI ]]
        -- upvalues: l_Templates_0 (copy), l_Contents_0 (copy), v5 (copy)
        if not v7 then
            v7 = 0;
        end;
        local l_v6_Attribute_0 = v6:GetAttribute("LayoutOrder");
        if not l_v6_Attribute_0 then
            return;
        else
            local l_v6_Attribute_1 = v6:GetAttribute("DisplayTitle");
            if not l_v6_Attribute_1 then
                return;
            else
                local l_v6_Attribute_2 = v6:GetAttribute("PostDisplayTitle");
                if v6:IsA("Folder") then
                    local v11 = l_Templates_0.Seperator:Clone();
                    v11.Name = v6.Name;
                    v11.LayoutOrder = l_v6_Attribute_0 * 100 + v7;
                    v11.Title.Text = l_v6_Attribute_1;
                    v11.Parent = l_Contents_0;
                    for _, v13 in pairs(v6:GetChildren()) do
                        v5(v13, l_v6_Attribute_0 * 100);
                    end;
                    return;
                else
                    if v6:IsA("NumberValue") then
                        local v14 = l_Templates_0.Title:Clone();
                        v14.Name = v6.Name;
                        v14.LayoutOrder = l_v6_Attribute_0 + v7;
                        v14.Parent = l_Contents_0;
                        local function v16() --[[ Line: 49 ]] --[[ Name: setText ]]
                            -- upvalues: l_v6_Attribute_2 (copy), v14 (copy), l_v6_Attribute_1 (copy), v6 (copy)
                            if l_v6_Attribute_2 == "Time" then
                                local v15 = require(game.ReplicatedStorage.Modules.Util);
                                v14.Text = ("%*: %*"):format(l_v6_Attribute_1, (v15:FormatTime(v6.Value, "String")));
                            else
                                v14.Text = ("%*: %*%*"):format(l_v6_Attribute_1, v6.Value, l_v6_Attribute_2 or "");
                            end;
                            if v6:GetAttribute("HideIfZero") then
                                v14.Visible = v6.Value ~= 0;
                            end;
                        end;
                        v6:GetPropertyChangedSignal("Value"):Connect(v16);
                        v16();
                    end;
                    return;
                end;
            end;
        end;
    end;
    for _, v18 in pairs(l_Stats_0:GetChildren()) do
        v5(v18);
    end;
end;
return v0;