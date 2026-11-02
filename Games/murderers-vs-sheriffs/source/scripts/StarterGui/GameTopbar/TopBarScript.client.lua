-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local l_Parent_0 = script.Parent;
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_InputContext_0 = l_PlayerGui_0:WaitForChild("InputContext");
local l_TouchEnabled_0 = l_UserInputService_0.TouchEnabled;
local l_Container_0 = l_Parent_0:WaitForChild("Container");
local l_Emotes_0 = l_Container_0:WaitForChild("Emotes");
local l_MouseLock_0 = l_Container_0:WaitForChild("MouseLock");
local l_Settings_0 = l_Container_0:WaitForChild("Settings");
local l_Button_0 = l_MouseLock_0:WaitForChild("Container"):WaitForChild("Button");
local l_MouseLock_1 = l_LocalPlayer_0.PlayerScripts:WaitForChild("MouseLock");
local l_Crosshair_0 = l_Parent_0:WaitForChild("Crosshair");
local l_KeyboardBinding_0 = l_InputContext_0:WaitForChild("GameplayContext"):WaitForChild("Emotes"):WaitForChild("KeyboardBinding");
local l_TextLabel_0 = l_Emotes_0:WaitForChild("Hotkey"):WaitForChild("ImageLabel"):WaitForChild("TextLabel");
local function v16(v15) --[[ Line: 27 ]] --[[ Name: updateMouseLockButton ]]
    l_Crosshair_0.Visible = v15 and l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch;
    l_MouseLock_0.Container.Background.UIStroke.Enabled = v15;
end;
local function v18() --[[ Line: 32 ]] --[[ Name: onMouseLockButtonActivated ]]
    local v17 = l_MouseLock_1:Invoke();
    l_Crosshair_0.Visible = v17 and l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch;
    l_MouseLock_0.Container.Background.UIStroke.Enabled = v17;
end;
local function v20() --[[ Line: 37 ]] --[[ Name: updateTopBar ]]
    local l_TopbarInset_0 = l_GuiService_0.TopbarInset;
    l_Container_0.Position = UDim2.new(0, l_TopbarInset_0.Min.X + 6, 0, 12);
    if l_GuiService_0:IsTenFootInterface() then
        l_Container_0.Visible = false;
    end;
end;
local function v21() --[[ Line: 45 ]] --[[ Name: onPreferredInputChanged ]]
    l_Emotes_0:WaitForChild("Hotkey").Visible = l_UserInputService_0.PreferredInput == Enum.PreferredInput.KeyboardAndMouse;
end;
local function v22() --[[ Line: 50 ]] --[[ Name: updateKeybinds ]]
    l_TextLabel_0.Text = l_KeyboardBinding_0.KeyCode.Name;
end;
(function() --[[ Line: 54 ]] --[[ Name: onInitialize ]]
    l_TextLabel_0.Text = l_KeyboardBinding_0.KeyCode.Name;
    l_KeyboardBinding_0:GetPropertyChangedSignal("KeyCode"):Connect(v22);
    l_MouseLock_0.Visible = l_TouchEnabled_0;
    l_Button_0.Activated:Connect(v18);
    local l_TopbarInset_1 = l_GuiService_0.TopbarInset;
    l_Container_0.Position = UDim2.new(0, l_TopbarInset_1.Min.X + 6, 0, 12);
    if l_GuiService_0:IsTenFootInterface() then
        l_Container_0.Visible = false;
	end;
	local Settings = l_Parent_0.Parent:WaitForChild("CrossPlatform"):WaitForChild("Settings")
	local function SStroke()
		l_Settings_0.Container.Background.UIStroke.Enabled = Settings.Visible
	end
	Settings:GetPropertyChangedSignal("Visible"):Connect(SStroke)
	SStroke()
    l_Emotes_0:WaitForChild("Hotkey").Visible = l_UserInputService_0.PreferredInput == Enum.PreferredInput.KeyboardAndMouse;
    l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(v21);
    l_GuiService_0:GetPropertyChangedSignal("TopbarInset"):Connect(v20);
    l_MouseLock_1:WaitForChild("MouseLockToggled").Event:Connect(v16);
    task.wait(2);
	l_TopbarInset_1 = l_GuiService_0.TopbarInset;
	l_Settings_0.Container.Button.Activated:Connect(function()
		require(game.ReplicatedStorage.Modules.WindowService):ToggleFrame("Settings")
	end)
    l_Container_0.Position = UDim2.new(0, l_TopbarInset_1.Min.X + 6, 0, 12);
    if l_GuiService_0:IsTenFootInterface() then
        l_Container_0.Visible = false;
    end;
end)();