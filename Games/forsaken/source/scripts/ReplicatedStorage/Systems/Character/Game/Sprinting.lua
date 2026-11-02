-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DefaultConfig = {
        IsSprinting = false, 
        StaminaLossDisabled = false, 
        MinStamina = 0, 
        MaxStamina = 100, 
        SprintSpeed = 26, 
        StaminaLoss = 10, 
        StaminaGain = 20
    }
};
local l_TweenService_0 = game:GetService("TweenService");
local v2 = require(game.ReplicatedStorage.Modules.Network);
v0.ChangeStat = function(_, v4, v5) --[[ Line: 20 ]] --[[ Name: ChangeStat ]]
    -- upvalues: v0 (copy)
    if v0[v4] then
        v0[v4] = v5;
    end;
end;
v0.Init = function(_) --[[ Line: 27 ]] --[[ Name: Init ]]
    -- upvalues: v0 (copy), l_TweenService_0 (copy), v2 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local l_Humanoid_0 = l_Character_0:WaitForChild("Humanoid");
    for v10, v11 in pairs(v0.DefaultConfig) do
        v0[v10] = v11;
    end;
    v0.StaminaCap = nil;
    v0.StaminaLossDisabled = false;
    v0.DefaultsSet = true;
    v0.__sprintedEvent = Instance.new("BindableEvent");
    v0.__staminaChangedEvent = Instance.new("BindableEvent");
    v0.__speedMultiplier = Instance.new("NumberValue");
    v0.__speedMultiplier.Value = 1;
    v0.__speedMultiplier.Name = "Sprinting";
    v0.__speedMultiplier.Parent = l_Character_0:WaitForChild("SpeedMultipliers", 10);
    v0.__FOVMultiplier = Instance.new("NumberValue");
    v0.__FOVMultiplier.Value = 1;
    v0.__FOVMultiplier.Name = "Sprinting";
    v0.__FOVMultiplier.Parent = l_Character_0:WaitForChild("FOVMultipliers", 10);
    v0.CanSprint = true;
    v0.SprintToggled = v0.__sprintedEvent.Event;
    v0.StaminaChanged = v0.__staminaChangedEvent.Event;
    v0.Stamina = v0.MaxStamina;
    v0.SprintToggled:Connect(function(v12) --[[ Line: 62 ]]
        -- upvalues: l_TweenService_0 (ref), v0 (ref), l_Humanoid_0 (copy)
        if v12 then
            l_TweenService_0:Create(v0.__FOVMultiplier, TweenInfo.new(0.75), {
                Value = 1.125
            }):Play();
            l_TweenService_0:Create(v0.__speedMultiplier, TweenInfo.new(0.75), {
                Value = v0.SprintSpeed / (l_Humanoid_0:GetAttribute("BaseSpeed") or 16)
            }):Play();
            return;
        else
            l_TweenService_0:Create(v0.__FOVMultiplier, TweenInfo.new(0.75), {
                Value = 1
            }):Play();
            l_TweenService_0:Create(v0.__speedMultiplier, TweenInfo.new(0.75), {
                Value = 1
            }):Play();
            return;
        end;
    end);
    local l_IsSprinting_0 = v0.IsSprinting;
    local v14 = 0;
    local function v17(_, v16) --[[ Line: 75 ]] --[[ Name: sprint ]]
        -- upvalues: v0 (ref), l_IsSprinting_0 (ref), v14 (ref)
        if not v0.CanSprint then
            return;
        else
            if require(game.ReplicatedStorage.Modules.Device):GetPlayerDevice() == "Mobile" then
                if v16 ~= Enum.UserInputState.Begin then
                    return;
                else
                    v16 = l_IsSprinting_0 and Enum.UserInputState.End or Enum.UserInputState.Begin;
                end;
            end;
            if v16 == Enum.UserInputState.Begin and v0.Stamina > v0.MinStamina and not v0.IsSprinting then
                v0.IsSprinting = true;
                v0.__sprintedEvent:Fire(true, l_IsSprinting_0);
                l_IsSprinting_0 = v0.IsSprinting;
                return;
            else
                if v0.IsSprinting then
                    v0.IsSprinting = false;
                    v0.__sprintedEvent:Fire(false, l_IsSprinting_0);
                    l_IsSprinting_0 = v0.IsSprinting;
                    if v14 > 0.1 then
                        v14 = math.clamp(v14 + 0.1, 0, 3);
                        return;
                    else
                        v14 = 0.1;
                    end;
                end;
                return;
            end;
        end;
    end;
    task.spawn(function() --[[ Line: 107 ]]
        -- upvalues: l_Character_0 (copy), v0 (ref), v14 (ref), l_IsSprinting_0 (ref)
        while true do
            local v18 = game["Run Service"].Heartbeat:Wait();
            if not l_Character_0.Parent then
                return;
            elseif not l_Character_0.PrimaryPart then
                return;
            elseif v0.IsSprinting and v0.Stamina > v0.MinStamina and l_Character_0.PrimaryPart.Velocity.Magnitude > 0.4 and v0.CanSprint and not v0.StaminaLossDisabled then
                v14 = math.clamp(v14 + v18 * 0.05, 0.2, 3);
                v0.Stamina = math.clamp(v0.Stamina - v0.StaminaLoss * v18, v0.MinStamina, v0.StaminaCap or v0.MaxStamina);
                v0.__staminaChangedEvent:Fire(v0.Stamina);
                if v0.Stamina <= v0.MinStamina then
                    v0.IsSprinting = false;
                    v0.__sprintedEvent:Fire(false, l_IsSprinting_0);
                    l_IsSprinting_0 = v0.IsSprinting;
                    v14 = 2;
                end;
            elseif v0.StaminaLossDisabled or not v0.IsSprinting or l_Character_0.PrimaryPart.Velocity.Magnitude <= 0.4 and (v0.Stamina < v0.MaxStamina or v0.StaminaCap and v0.Stamina > v0.StaminaCap) then
                v14 = math.clamp(v14 - v18, 0, 3);
                if v14 <= 0 then
                    v0.Stamina = math.clamp(v0.Stamina + v0.StaminaGain * v18, v0.MinStamina, v0.StaminaCap or v0.MaxStamina);
                    v0.__staminaChangedEvent:Fire(v0.Stamina);
                end;
            end;
        end;
    end);
    local v19 = {};
    local l_Keybinds_0 = l_LocalPlayer_0.PlayerData.Settings.Keybinds;
    for _, v22 in pairs({
        l_Keybinds_0.Sprinting.Value, 
        l_Keybinds_0["Sprinting~Console"].Value
    }) do
        for _, v24 in pairs(Enum.KeyCode:GetEnumItems()) do
            if v24.Name == v22 then
                table.insert(v19, v24);
                break;
            end;
        end;
        for _, v26 in pairs(Enum.UserInputType:GetEnumItems()) do
            if v26.Name == v22 then
                table.insert(v19, v26);
                break;
            end;
        end;
    end;
    game.ContextActionService:BindActionAtPriority("Sprinting", v17, false, 10000, unpack(v19));
    if not v0.MobileButton then
        local v27 = script.SprintingButton:Clone();
        v27.Parent = l_LocalPlayer_0.PlayerGui:WaitForChild("MainUI");
        local v28 = require(game.ReplicatedStorage.Modules.Device);
        local l_v27_0 = v27 --[[ copy: 9 -> 19 ]];
        local function v30() --[[ Line: 172 ]] --[[ Name: toggleButton ]]
            -- upvalues: v28 (copy), l_v27_0 (copy)
            l_v27_0.Visible = v28:GetPlayerDevice() == "Mobile";
        end;
        v27.Visible = v28:GetPlayerDevice() == "Mobile";
        v28.Changed:Connect(v30);
        v0.MobileButton = v27;
    end;
    if tostring(l_LocalPlayer_0.Character.Parent) == "Spectating" and v0.MobileButton then
        v0.MobileButton.AnchorPoint = Vector2.new(0, 0);
        v0.MobileButton.Position = UDim2.new(1, -250, 1, -135);
        v0.MobileButton.Size = UDim2.fromOffset(83, 83);
    end;
    if v0.CurrentButtonConnection1 then
        v0.CurrentButtonConnection1:Disconnect();
    end;
    v0.CurrentButtonConnection1 = v0.MobileButton.MouseButton1Down:Connect(function() --[[ Line: 192 ]]
        -- upvalues: v0 (ref), v17 (copy)
        v0.MobileButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75);
        v17("Sprinting", Enum.UserInputState.Begin);
    end);
    if v0.CurrentButtonConnection2 then
        v0.CurrentButtonConnection2:Disconnect();
    end;
    v0.CurrentButtonConnection2 = v0.MobileButton.MouseButton1Up:Connect(function() --[[ Line: 198 ]]
        -- upvalues: v0 (ref), v17 (copy)
        v0.MobileButton.ImageColor3 = Color3.new(1, 1, 1);
        v17("Sprinting", Enum.UserInputState.End);
    end);
    local v31 = {};
    v2:SetConnection("DisableSprinting", "BINDABLE_EVENT", function(v32, v33) --[[ Line: 205 ]]
        -- upvalues: v31 (copy), v0 (ref), l_IsSprinting_0 (ref)
        v31[v32] = v33;
        local v34 = true;
        for _, v36 in pairs(v31) do
            if v36 == true then
                v34 = false;
                break;
            end;
        end;
        v0.CanSprint = v34;
        if not v34 and v0.IsSprinting then
            v0.IsSprinting = false;
            v0.__sprintedEvent:Fire(false, l_IsSprinting_0);
            l_IsSprinting_0 = v0.IsSprinting;
        end;
    end);
    v2:SetConnection("GrantStamina", "REMOTE_EVENT", function(v37) --[[ Line: 229 ]]
        -- upvalues: v0 (ref)
        v0.Stamina = math.min(v0.Stamina + v37, v0.MaxStamina);
    end);
    v0.Character = l_Character_0;
end;
v0.Destroy = function(_) --[[ Line: 238 ]] --[[ Name: Destroy ]]
    -- upvalues: v2 (copy), v0 (copy)
    v2:RemoveConnection("DisableSprinting");
    v0.__sprintedEvent:Destroy();
    v0.__staminaChangedEvent:Destroy();
    v0.__speedMultiplier:Destroy();
    v0.__FOVMultiplier:Destroy();
end;
return v0;