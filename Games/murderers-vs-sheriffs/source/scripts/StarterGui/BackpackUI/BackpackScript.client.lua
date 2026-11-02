-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_StarterGui_0 = game:GetService("StarterGui");
local l_DeviceService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("DeviceService"));
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Parent_0 = script.Parent;
local l_BackpackFrame_0 = l_Parent_0:WaitForChild("BackpackFrame");
local l_BackpackItem_0 = l_BackpackFrame_0:WaitForChild("BackpackItem");
l_BackpackItem_0.Parent = script;
local l_BackpackInputContext_0 = l_Parent_0:WaitForChild("BackpackInputContext");
local v9 = { 
    [1] = "Weapon"
};
local v10 = {};
local v11 = 10;
local function _(v12) --[[ Line: 22 ]] --[[ Name: getBackpackIndex ]]
    for v13, v14 in v9 do
        if v14 == v12 then
            return v13;
        end;
    end;
end;
local function v22(v16) --[[ Line: 30 ]] --[[ Name: updateItemFrame ]]
    local v17 = false;
    local v18 = v10[v16];
    if not v18 then
        return;
    else
        local v19;
        for v20, v21 in v9 do
            if v21 == v16 then
                v19 = v20;
                v17 = true;
            end;
            if v17 then
                break;
            end;
        end;
        if not v17 then
            v19 = nil;
        end;
        v17 = false;
        v18.Container.Hotkey.Text = v19 == 10 and 0 or v19;
        v18.Container.Hotkey.Visible = l_UserInputService_0.PreferredInput == Enum.PreferredInput.KeyboardAndMouse;
        v18.Container.NameLabel.Text = v16.TextureId == "" and v16.Name or "";
        v18.Container.ToolIcon.Image = v16.TextureId;
        v18.LayoutOrder = v19;
        v18.Visible = v19 <= v11;
        if v19 <= 10 then
            l_BackpackInputContext_0:FindFirstChild("Item" .. v19):FindFirstChild("InputBinding").UIButton = nil;
        end;
        return;
    end;
end;
local function _(v23) --[[ Line: 51 ]] --[[ Name: onItemUnequipped ]]
    v10[v23].Equipped.Visible = false;
end;
local function v32(v25) --[[ Line: 55 ]] --[[ Name: onItemEquipped ]]
    local v26 = false;
    local v27;
    for v28, v29 in v9 do
        if v29 == v25 then
            v27 = v28;
            v26 = true;
        end;
        if v26 then
            break;
        end;
    end;
    if not v26 then
        v27 = nil;
    end;
    v26 = false;
    if v11 < v27 then
        table.remove(v9, v27);
        table.insert(v9, 2, v25);
        for _, v31 in v9 do
            v22(v31);
        end;
    end;
    v10[v25].Equipped.Visible = true;
end;
local function _(v33) --[[ Line: 68 ]] --[[ Name: findBackpackIndex ]]
	if v33:HasTag("Weapon") or v33:HasTag("Weapon_Knife") or v33:HasTag("Weapon_Gun") then
        return 1;
    else
        for v34, v35 in v9 do
            if v35 == "Empty" then
                return v34;
            end;
        end;
        return nil;
    end;
end;
local function equipToolFromSlot(Tool)
    if type(Tool) ~= "userdata" or not Tool:IsA("Tool") then
        return;
    end;

    local Character = l_LocalPlayer_0.Character;
    if not Character then
        return;
    end;

    local Humanoid = Character:FindFirstChildOfClass("Humanoid");
    if not Humanoid then
        return;
    end;

    if Tool.Parent == l_LocalPlayer_0.Backpack then
        Humanoid:EquipTool(Tool);
    elseif Tool.Parent == Character then
        Humanoid:UnequipTools();
    end;
end;

local function v55(v37) --[[ Line: 83 ]] --[[ Name: onItemAdded ]]
    local v38 = false;
    local v39 = false;
    if not v37:IsA("Tool") then
        return;
    else
        local v40;
        for v41, v42 in v9 do
            if v42 == v37 then
                v40 = v41;
                v38 = true;
            end;
            if v38 then
                break;
            end;
        end;
        if not v38 then
            v40 = nil;
        end;
        v38 = false;
        if v40 then
            if v37.Parent == l_LocalPlayer_0.Backpack then
                v10[v37].Equipped.Visible = false;
                return;
            else
                if v37.Parent == l_LocalPlayer_0.Character then
                    v32(v37);
                end;
                return;
            end;
        else
            local v43;
            if v37:HasTag("Weapon") then
                v43 = 1;
            else
                for v44, v45 in v9 do
                    if v45 == "Empty" then
                        v43 = v44;
                        v39 = true;
                    end;
                    if v39 then
                        break;
                    end;
                end;
                if not v39 then
                    v43 = nil;
                end;
            end;
            v39 = false;
            if v43 then
                v9[v43] = v37;
            else
                table.insert(v9, v37);
            end;
            local v46 = l_BackpackItem_0:Clone();
            v46.Visible = false;
            v10[v37] = v46;
            v46.Parent = l_BackpackFrame_0;
            for _, v48 in v9 do
                if v48 ~= v37 then
                    v22(v48);
                end;
            end;
            v22(v37);
            v46.EquipButton.Activated:Connect(function()
                equipToolFromSlot(v37);
            end);
            v46:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 117 ]]
                v46.Container.NameLabel.Text = v37.Name;
            end);
            local v49 = nil;
            v49 = v37:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 122 ]]
                local v50 = false;
                local l_v37_0 = v37;
                local v52;
                for v53, v54 in v9 do
                    if v54 == l_v37_0 then
                        v52 = v53;
                        v50 = true;
                    end;
                    if v50 then
                        break;
                    end;
                end;
                if not v50 then
                    v52 = nil;
                end;
                v50 = false;
                if not l_LocalPlayer_0:FindFirstChildOfClass("Backpack") then
                    v49:Disconnect();
                    v46:Destroy();
                    if v52 == 1 then
                        v9[v52] = "Weapon";
                        return;
                    else
                        v9[v52] = "Empty";
                        return;
                    end;
                elseif v37.Parent == nil and v37.Parent ~= l_LocalPlayer_0.Backpack and v37.Parent ~= l_LocalPlayer_0.Character then
                    v49:Disconnect();
                    v46:Destroy();
                    if v52 == 1 then
                        v9[v52] = "Weapon";
                        return;
                    else
                        v9[v52] = "Empty";
                        return;
                    end;
                else
                    return;
                end;
            end);
            return;
        end;
    end;
end;
local function v62(v56) --[[ Line: 147 ]] --[[ Name: onCharacterAdded ]]
    local l_Backpack_0 = l_LocalPlayer_0.Backpack;
    for _, v59 in l_Backpack_0:GetChildren() do
        v55(v59);
    end;
    for _, v61 in v56:GetChildren() do
        v55(v61);
    end;
    l_Backpack_0.ChildAdded:Connect(v55);
    v56.ChildAdded:Connect(v55);
end;
local function v73(v63) --[[ Line: 159 ]] --[[ Name: equipItemInDirection ]]
    local v64 = false;
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 then
        return;
    else
        local l_Humanoid_0 = l_Character_0:FindFirstChildOfClass("Humanoid");
        if not l_Humanoid_0 then
            return;
        else
            local l_Tool_0 = l_Character_0:FindFirstChildOfClass("Tool");
            if not l_Tool_0 then
                local v68 = v9[1];
                if type(v68) ~= "userdata" then
                    v68 = v9[2];
                    if type(v68) ~= "userdata" then
                        return;
                    end;
                end;
                if v68.Parent == l_LocalPlayer_0.Backpack then
                    l_Humanoid_0:EquipTool(v68);
                    return;
                end;
            end;
            local v69;
            for v70, v71 in v9 do
                if v71 == l_Tool_0 then
                    v69 = v70;
                    v64 = true;
                end;
                if v64 then
                    break;
                end;
            end;
            if not v64 then
                v69 = nil;
            end;
            v64 = false;
            local v72 = v9[v69 + v63];
            if type(v72) ~= "userdata" then
                l_Humanoid_0:UnequipTools();
                return;
            elseif v72.Parent == l_LocalPlayer_0.Backpack then
                l_Humanoid_0:EquipTool(v72);
                return;
            else
                return;
            end;
        end;
    end;
end;
(function() --[[ Line: 195 ]] --[[ Name: onInitialize ]]
    if l_GuiService_0:IsTenFootInterface() then
        return;
    else
        if l_DeviceService_0:IsMobileDevice() then
            v11 = 3;
        end;
        v62(l_LocalPlayer_0.Character);
		l_LocalPlayer_0.CharacterAdded:Connect(function(character)
			for _, frame in pairs(l_BackpackFrame_0:GetChildren()) do
				if frame:IsA("Frame") then
					frame:Destroy()
				end
			end
			table.clear(v9)
			table.clear(v10)
			v9[1] = "Weapon"

			v62(character)
		end)
        for _, v75 in l_BackpackInputContext_0:GetChildren() do
            local v76 = tonumber((string.sub(v75.Name, 5)));
            v75.Pressed:Connect(function() --[[ Line: 208 ]]
                local v77 = v9[v76];
                if not v77 then
                    return;
                elseif type(v77) ~= "userdata" then
                    return;
                else
                    local l_Character_1 = l_LocalPlayer_0.Character;
                    if not l_Character_1 then
                        return;
                    else
                        local l_Humanoid_1 = l_Character_1:FindFirstChildOfClass("Humanoid");
                        if not l_Humanoid_1 then
                            return;
                        else
                            equipToolFromSlot(v77);
                            return;
                        end;
                    end;
                end;
            end);
        end;
        l_BackpackInputContext_0:WaitForChild("GamepadLeft").Pressed:Connect(function() --[[ Line: 234 ]]
            v73(-1);
        end);
        l_BackpackInputContext_0:WaitForChild("GamepadRight").Pressed:Connect(function() --[[ Line: 237 ]]
            v73(1);
        end);
        task.spawn(function() --[[ Line: 241 ]]
            while task.wait() do
                l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
            end;
        end);
        return;
    end;
end)();