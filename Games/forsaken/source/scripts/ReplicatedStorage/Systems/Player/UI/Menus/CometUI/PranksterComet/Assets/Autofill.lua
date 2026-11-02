-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Mouse_0 = game.Players.LocalPlayer:GetMouse();
local l_UserInputService_0 = game:GetService("UserInputService");
local v2 = Color3.new(1, 0.317647, 0);
local v3 = Color3.new(1, 1, 1);
local v4 = {};
v4.__index = v4;
v4.new = function(v5, v6) --[[ Line: 11 ]] --[[ Name: new ]]
    -- upvalues: v4 (copy), l_UserInputService_0 (copy), l_Mouse_0 (copy)
    local v7 = setmetatable({}, v4);
    v7.Typing = false;
    v7.Instance = v5;
    v7.Selection = v6 or {
        "Turn", 
        "The", 
        "Freaking", 
        "Frogs", 
        "Gay"
    };
    v7.CurrentSelection = nil;
    v7.AutofillBox = script.FillBox:Clone();
    v7.AutofillBox.Position = v5.Position;
    v7.FillTemplate = v7.AutofillBox.Template;
    v7.FillTemplate.Parent = nil;
    game["Run Service"].Heartbeat:Connect(function() --[[ Line: 22 ]]
        -- upvalues: v7 (copy), l_UserInputService_0 (ref), l_Mouse_0 (ref)
        if v7 and v7.Typing then
            local _ = l_UserInputService_0:GetMouseLocation();
            local v9 = UDim2.new(0, l_Mouse_0.X, 0, l_Mouse_0.Y);
            v7.AutofillBox.Position = v9;
        end;
    end);
    v5.Focused:Connect(function() --[[ Line: 30 ]]
        -- upvalues: v7 (copy)
        if not v7.Selection then
            return;
        else
            v7.Typing = true;
            v7.AutofillBox.Visible = true;
            v7.AutofillBox.Parent = script.Parent.Parent;
            v7:UpdateFillBox();
            return;
        end;
    end);
    v5.FocusLost:Connect(function() --[[ Line: 38 ]]
        -- upvalues: v7 (copy)
        v7.Typing = false;
        if v7.CurrentSelection then
            v7.Instance.Text = v7.CurrentSelection:GetAttribute("FillingFor");
        end;
        v7.AutofillBox.Visible = false;
        v7.AutofillBox.Parent = nil;
        v7.CurrentSelection = nil;
    end);
    v5.Changed:Connect(function(v10) --[[ Line: 48 ]]
        -- upvalues: v7 (copy)
        if v10 == "Text" and v7.Typing then
            v7:UpdateFillBox();
        end;
    end);
    l_UserInputService_0.InputBegan:Connect(function(v11) --[[ Line: 54 ]]
        -- upvalues: v7 (copy)
        if not v7.Typing or not v7.CurrentSelection then
            return;
        else
            if v11.KeyCode == Enum.KeyCode.Down then
                local v12 = tonumber(v7.CurrentSelection.Name) - 1;
                if v7.AutofillBox:FindFirstChild((tostring(v12))) then
                    v7:Select(v7.AutofillBox[tostring(v12)]);
                    return;
                end;
            elseif v11.KeyCode == Enum.KeyCode.Up then
                local v13 = tonumber(v7.CurrentSelection.Name) + 1;
                if v7.AutofillBox:FindFirstChild((tostring(v13))) then
                    v7:Select(v7.AutofillBox[tostring(v13)]);
                end;
            end;
            return;
        end;
    end);
    v7:UpdateFillBox();
    return v7;
end;
v4.UpdateFillBox = function(v14) --[[ Line: 78 ]] --[[ Name: UpdateFillBox ]]
    -- upvalues: v3 (copy), v2 (copy)
    if not v14.Selection then
        return;
    else
        local l_Text_0 = v14.Instance.Text;
        for _, v17 in ipairs(v14.AutofillBox:GetChildren()) do
            if v17:IsA("TextLabel") then
                v17:Destroy();
            end;
        end;
        if l_Text_0 == "" then
            return;
        else
            local v18 = 1;
            v14.CurrentSelection = nil;
            for _, v20 in ipairs(v14.Selection) do
                local v21 = string.lower(v20);
                local v22 = string.lower(l_Text_0);
                local v23, _ = v20:find(l_Text_0);
                local v25 = v21:find(v22);
                if v23 or v25 then
                    local v26 = v14.FillTemplate:Clone();
                    v26.Parent = v14.AutofillBox;
                    v26.Name = v18;
                    v26.Text = v20:gsub(l_Text_0, (("<b>%*</b>"):format(l_Text_0)));
                    v26:SetAttribute("FillingFor", v20);
                    v26.LayoutOrder = 9999 - v18;
                    if v18 == 1 then
                        v14.CurrentSelection = v26;
                        v26.TextColor3 = v3;
                        v26.BackgroundColor3 = v2;
                    else
                        v26.TextColor3 = v2;
                        v26.BackgroundColor3 = v3;
                    end;
                    v18 = v18 + 1;
                end;
            end;
            return;
        end;
    end;
end;
v4.Select = function(v27, v28) --[[ Line: 121 ]] --[[ Name: Select ]]
    -- upvalues: v3 (copy), v2 (copy)
    v27.CurrentSelection = nil;
    for _, v30 in ipairs(v27.AutofillBox:GetChildren()) do
        if v30:IsA("TextLabel") then
            if v30 == v28 then
                v30.TextColor3 = v3;
                v30.BackgroundColor3 = v2;
            else
                v30.TextColor3 = v2;
                v30.BackgroundColor3 = v3;
            end;
        end;
    end;
    v27.CurrentSelection = v28;
end;
v4.UpdateSelection = function(v31, v32) --[[ Line: 137 ]] --[[ Name: UpdateSelection ]]
    v31.Instance.Text = "";
    v31.Selection = v32;
    v31:UpdateFillBox();
end;
return v4;