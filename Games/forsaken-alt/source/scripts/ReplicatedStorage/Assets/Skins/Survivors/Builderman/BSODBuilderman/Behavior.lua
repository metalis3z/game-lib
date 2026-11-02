-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreatedPost = function(_, v1) --[[ Line: 4 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            local v2 = nil;
            local l_Humanoid_0 = v1.Rig.Humanoid;
            local l_Title_0 = v1.Rig.ExpressionHolder.FaceGui.Title;
            do
                local l_v2_0 = v2;
                v1.ChangeExpression = function(_, v7, v8, v9) --[[ Line: 10 ]] --[[ Name: ChangeExpression ]]
                    -- upvalues: l_Title_0 (copy), v1 (copy), l_v2_0 (ref), l_Humanoid_0 (copy)
                    if not l_Title_0.Parent then
                        return;
                    elseif not v1.Config.Expressions[v7] and not v9 then
                        return;
                    else
                        if l_v2_0 then
                            task.cancel(l_v2_0);
                        end;
                        if v9 then
                            l_Title_0.Text = tostring(v7);
                        elseif v7 == "Default" then
                            l_Title_0.Text = l_Humanoid_0.Health <= l_Humanoid_0.MaxHealth / 2 and tostring(v1.Config.Expressions.Injured) or tostring(v1.Config.Expressions.Default);
                        else
                            l_Title_0.Text = tostring(v1.Config.Expressions[v7]);
                        end;
                        if v8 then
                            l_v2_0 = task.delay(v8, function() --[[ Line: 26 ]]
                                -- upvalues: l_Title_0 (ref), l_Humanoid_0 (ref), v1 (ref)
                                l_Title_0.Text = l_Humanoid_0.Health <= l_Humanoid_0.MaxHealth / 2 and tostring(v1.Config.Expressions.Injured) or tostring(v1.Config.Expressions.Default);
                            end);
                        end;
                        return;
                    end;
                end;
                local _ = {
                    [":3"] = true, 
                    [":)"] = true, 
                    [":("] = true, 
                    [":D"] = true, 
                    [":C"] = true, 
                    XD = true, 
                    [":/"] = true, 
                    [":P"] = true, 
                    ["3:"] = true, 
                    ["):"] = true, 
                    ["(:"] = true, 
                    ["D:"] = true, 
                    ["C:"] = true, 
                    DX = true, 
                    ["/:"] = true, 
                    ["3:<"] = true, 
                    ["):<"] = true, 
                    ["(:<"] = true, 
                    ["D:<"] = true, 
                    ["C:<"] = true, 
                    ["/:<"] = true, 
                    ["<:3"] = true, 
                    ["<:)"] = true, 
                    ["<:("] = true, 
                    ["<:D"] = true, 
                    ["3:>"] = true, 
                    ["(:>"] = true, 
                    ["):>"] = true, 
                    ["D:>"] = true, 
                    O_O = true, 
                    ["O.O"] = true, 
                    Q_Q = true, 
                    ["Q.Q"] = true, 
                    [">_>"] = true, 
                    ["<_<"] = true, 
                    ["^_^"] = true, 
                    UWU = true, 
                    OWO = true
                };
                local v11 = nil;
                v11 = v1.Player.Chatted:Connect(function(v12) --[[ Line: 82 ]]
                    -- upvalues: l_Title_0 (copy), v11 (ref), v1 (copy)
                    if not l_Title_0.Parent then
                        v11:Disconnect();
                        v11 = nil;
                        return;
                    else
                        local v13 = v12:gsub("&gt;", ">"):gsub("&lt;", "<");
                        if not (#v13 <= 3) then
                            return;
                        else
                            if not game["Run Service"]:IsStudio() then
                                v13 = game:GetService("Chat"):FilterStringForBroadcast(v13, v1.Player);
                            end;
                            v1:ChangeExpression(v13, 15, true);
                            local v14 = v12:lower();
                            if v14:find("uwu") or v14:find("owo") then
                                local v15 = require(game.ReplicatedStorage.Modules.Statuses);
                                v15:ApplyStatus(v1.Player, "Slowness", {
                                    Duration = 99999, 
                                    Level = 5
                                });
                                v15:ApplyStatus(v1.Player, "Burning", {
                                    Duration = 99999, 
                                    Level = 5
                                });
                                v15:ApplyStatus(v1.Player, "Weakness", {
                                    Duration = 99999, 
                                    Level = 5
                                });
                            end;
                            return;
                        end;
                    end;
                end);
            end;
        end;
    end
};