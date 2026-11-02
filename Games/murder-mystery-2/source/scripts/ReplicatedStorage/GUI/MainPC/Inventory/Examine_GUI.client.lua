local GameGUI = script.Parent.Parent.Game;
local InventoryFrame = GameGUI.ViewProfile;
local Navigation = InventoryFrame.Nav;
local Main = InventoryFrame.Main;
local Dock = GameGUI.Dock;

local NavOrder = {"Weapons";"Effects";"Perks";"Emotes";"Radios";"Profile","Pets","Outfits"};
local Time = 0.2;
local Style = "Quad";
local Direction = "Out";

local CurrentFrame = "Profile";
local CurrentAction = "Equip";
local Tweening = false;


local WeaponsFrame = InventoryFrame.Main.Weapons;
for _,NavButton in pairs(Navigation:GetChildren()) do
	if NavButton:IsA("TextButton") then
		NavButton.MouseButton1Click:connect(function()
			local CurrentIndex;
			local NextIndex;
			local NextFrame = NavButton.Name;
			if NextFrame ~= CurrentFrame and not Tweening then
				for _,Button in pairs(Navigation:GetChildren()) do if Button:IsA("TextButton") then Button.Style = (Button==NavButton and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton; end; end;
				Main[NextFrame].Visible = true
				Main[CurrentFrame].Visible = false
				CurrentFrame = NextFrame;
				wait(Time);
				Tweening = false;
			end;
		end)
	end;
end

_G.Windows.Frames[InventoryFrame] = true;
_G.Windows.FrameNames.ViewProfile = InventoryFrame;

-- Profile