-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Debris_0 = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.GlobalTypes);
return {
    CreatedPost = function(_, v4) --[[ Line: 10 ]] --[[ Name: CreatedPost ]]
        -- upvalues: l_Debris_0 (copy)
        local l_Humanoid_0 = v4.Rig:FindFirstChildOfClass("Humanoid");
        if not l_Humanoid_0 then
            return;
        else
            local l_Highlight_0 = Instance.new("Highlight");
            l_Highlight_0:SetAttribute("Bypassable", true);
            l_Highlight_0.OutlineColor = Color3.fromRGB(255, 85, 176);
            l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_0.FillTransparency = 1;
            l_Highlight_0.OutlineTransparency = 0;
            l_Highlight_0.Enabled = false;
            l_Highlight_0.Parent = v4.Rig;
            local v7 = false;
            l_Humanoid_0.HealthChanged:Connect(function(v8) --[[ Line: 24 ]]
                -- upvalues: v7 (ref), v4 (copy)
                if v8 < 50 and not v7 then
                    v7 = true;
                    for _, v10 in (v4.Rig.Friend:GetDescendants()) do
                        if v10:IsA("UnionOperation") then
                            v10.UsePartColor = true;
                        end;
                        if v10:IsA("BasePart") then
                            local v11 = v10.Color.R * 255;
                            local v12 = v10.Color.G * 255;
                            local v13 = v10.Color.B * 255;
                            local v14, v15, v16 = v10.Color:ToHSV();
                            local function _(v17, v18, v19) --[[ Line: 38 ]] --[[ Name: getLuminance ]]
                                -- upvalues: v14 (copy), v15 (copy), v16 (copy)
                                return v14 * v17 + v15 * v18 + v16 * v19;
                            end;
                            local v21 = v14 * v11 + v15 * v12 + v16 * v13;
                            local v22 = math.min(v11 + 15, 255);
                            local v23 = math.clamp(v12 - 30, 0, 255);
                            local v24 = math.clamp(v13 - 40, 0, 255);
                            local v25 = v21 / (v14 * v22 + v15 * v23 + v16 * v24);
                            v22 = math.clamp(v22 * v25, 0, 255);
                            v23 = math.clamp(v23 * v25, 0, 255);
                            v24 = math.clamp(v24 * v25, 0, 255);
                            v10.Color = Color3.fromRGB(v22, v23, v24);
                        end;
                    end;
                end;
            end);
            l_Humanoid_0.Died:Once(function() --[[ Line: 62 ]]
                -- upvalues: v4 (copy), l_Highlight_0 (copy), l_Debris_0 (ref)
                for _, v27 in (v4.Rig.Friend:GetDescendants()) do
                    if v27:IsA("UnionOperation") then
                        v27.UsePartColor = true;
                    end;
                    if v27:IsA("BasePart") then
                        v27.Color = Color3.fromRGB(0, 0, 0);
                    end;
                end;
                l_Highlight_0.Enabled = true;
                l_Debris_0:AddItem(l_Highlight_0, 10);
            end);
            return;
        end;
    end
};