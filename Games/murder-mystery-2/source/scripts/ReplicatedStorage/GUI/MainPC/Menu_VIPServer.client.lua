local ServerSettings,IsOwner = game.ReplicatedStorage.GetServerSettings:InvokeServer();
local HasRadio,CanUse = game.ReplicatedStorage.HasRadio:InvokeServer();
local MainGUI = script.Parent.Game;
local SettingsButton = MainGUI.Settings.VIPSettings;


local TestServerID = 13027726810;
local MM2ID = 13085716426;
local HardcoreID = 335132309;
local HardcorelTestID = 13547305580;

local IsHardcore = (game.PlaceId == HardcoreID or game.PlaceId == HardcorelTestID);
if IsHardcore then HasRadio = false; end;



if CanUse then
	MainGUI.Settings.Size = UDim2.new(0,200,0,50);
	MainGUI.Settings.Radio.Visible = true;
else
	MainGUI.Settings.Radio.Visible = false;
	MainGUI.Settings.VIPSettings.Position = MainGUI.Settings.Radio.Position;
end;	
	

--[[game.ReplicatedStorage.GetRadio.OnClientEvent:connect(function()
	if not IsOwner then
		MainGUI.Settings.Size = UDim2.new(0,200,0,50);
		MainGUI.Settings.Radio.Visible = true;
	else
		MainGUI.Settings.Size = UDim2.new(0,250,0,50);
		SettingsButton.Position = UDim2.new(0,200,0,0);
	end;
end)]]

if ServerSettings and IsOwner then
	local SettingsFrame = MainGUI.SettingsFrame;
	local TimerMain = SettingsFrame.Settings:WaitForChild("RoundTimer")
	
	--[[if not HasRadio then
		MainGUI.Settings.Size = UDim2.new(0,150,0,50);
	else
		MainGUI.Settings.Size = UDim2.new(0,200,0,50);
		SettingsButton.Position = UDim2.new(0,200,0,0);
	end;]]
	
	if CanUse then
		MainGUI.Settings.Size = UDim2.new(0,250,0,50);
	else
		MainGUI.Settings.Size = UDim2.new(0,200,0,50);
	end;
	
	SettingsButton.Visible = true;
	
	SettingsButton.MouseButton1Click:connect(function()
		SettingsFrame.Visible = not SettingsFrame.Visible;
	end)
	
	SettingsFrame.Close.MouseButton1Click:connect(function()
		SettingsFrame.Visible = false;
	end)
	
	local function ResetTimers()
		for i,x in pairs(TimerMain.Options:GetChildren()) do
			if x:IsA("TextButton") then
				x.Style = Enum.ButtonStyle.RobloxRoundButton
			end
		end
	end
	
	local function UpdateSettings()
		for _,SettingFrame in pairs(SettingsFrame.Settings:GetChildren()) do
			if SettingFrame:FindFirstChild("Button") and SettingsFrame.Name ~= "RoundTimer" then
				if ServerSettings[SettingFrame.Name] == true then
					SettingFrame.Button.Text = "On";
					SettingFrame.Button.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
				else
					SettingFrame.Button.Text = "Off";
					SettingFrame.Button.Style = Enum.ButtonStyle.RobloxRoundButton;
				end;
			end;
		end
	end
	
	for _,SettingFrame in pairs(SettingsFrame.Settings:GetChildren()) do
		if ServerSettings[SettingFrame.Name] ~= nil then
			SettingFrame.Button.MouseButton1Click:connect(function()
				ServerSettings[SettingFrame.Name] = not ServerSettings[SettingFrame.Name];
				UpdateSettings();
				game.ReplicatedStorage.UpdateServerSettings:FireServer(ServerSettings);
			end)
		end;
	end	
	
	UpdateSettings();	
	
else
	if not CanUse then
		MainGUI.Settings.Size = UDim2.new(0,150,0,50);
	end
end;