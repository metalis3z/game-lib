-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_TweenService_0 = game:GetService("TweenService");
local v2 = TweenInfo.new(0.6, Enum.EasingStyle.Sine);
local v3 = TweenInfo.new(0.6, Enum.EasingStyle.Sine);
local l_Template_0 = script:WaitForChild("Template");
local l_TemplateReb_0 = script:WaitForChild("TemplateReb");
local function _(v6) --[[ Line: 15 ]] --[[ Name: getRootPart ]]
    local l_Character_0 = v6.Character;
    if not l_Character_0 then
        return nil;
    else
        return l_Character_0:FindFirstChild("HumanoidRootPart");
    end;
end;
local function v19(v9, v10, v11, v12) --[[ Line: 22 ]] --[[ Name: spawnBillboard ]]
    -- upvalues: l_TweenService_0 (copy), v2 (copy), v3 (copy)
    local l_Character_1 = v9.Character;
    local v14 = if not l_Character_1 then nil else l_Character_1:FindFirstChild("HumanoidRootPart");
    if not v14 then
        return;
    else
        l_Character_1 = v10:Clone();
        l_Character_1.Parent = workspace.Debris;
        l_Character_1.CFrame = v14.CFrame * v11;
        local l_BillboardGui_0 = l_Character_1:FindFirstChildOfClass("BillboardGui");
        if l_BillboardGui_0 then
            l_BillboardGui_0.Adornee = v14;
        end;
        local v16 = l_BillboardGui_0 and l_BillboardGui_0:FindFirstChildOfClass("TextLabel") or nil;
        local v17 = v16 and v16:FindFirstChildOfClass("UIStroke") or nil;
        local v18 = l_Character_1.Position + Vector3.new(0, 4, 0, 0);
        l_TweenService_0:Create(l_Character_1, v2, {
            Position = v18
        }):Play();
        task.delay(v12, function() --[[ Line: 45 ]]
            -- upvalues: l_Character_1 (copy), v16 (copy), l_TweenService_0 (ref), v3 (ref), v17 (copy)
            if not l_Character_1.Parent then
                return;
            else
                if v16 then
                    l_TweenService_0:Create(v16, v3, {
                        TextTransparency = 1
                    }):Play();
                end;
                if v17 then
                    l_TweenService_0:Create(v17, v3, {
                        Transparency = 1
                    }):Play();
                end;
                task.delay(0.6, function() --[[ Line: 56 ]]
                    -- upvalues: l_Character_1 (ref)
                    if l_Character_1 and l_Character_1.Parent then
                        l_Character_1:Destroy();
                    end;
                end);
                return;
            end;
        end);
        return;
    end;
end;
v0.new = function(v20) --[[ Line: 64 ]] --[[ Name: new ]]
    -- upvalues: v19 (copy), l_Template_0 (copy)
    v19(v20, l_Template_0, CFrame.new(3.2, -1, 0), 1.75);
end;
v0.Rebirthed = function(v21) --[[ Line: 69 ]] --[[ Name: Rebirthed ]]
    -- upvalues: v19 (copy), l_TemplateReb_0 (copy)
    v19(v21, l_TemplateReb_0, CFrame.new(-2, 0, 0), 0.8);
end;
return v0;