local GameGUI = script.Parent.Parent;

local Actions = game:GetService("ContextActionService");
local Bind = function(Name,Button,Function)
	local F = function(_,State)
		if State == Enum.UserInputState.Begin and (not _G.PauseBinds) then
			Function();
		end
	end
	Actions:BindAction(Name,F,false,Button);
end
local Unbind = function(Name,Button,Function)
	Actions:UnbindAction(Name);
end


Bind("EquipWeapons",Enum.KeyCode.ButtonL1,function()
	for _,Obj in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if Obj:IsA("Tool") then
			Obj.Parent = game.Players.LocalPlayer.Character;
			return;
		end
	end
	for _,Obj in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if Obj:IsA("Tool") then
			Obj.Parent = game.Players.LocalPlayer.Backpack;
			return;
		end
	end
end)

game.Players.LocalPlayer.Backpack.ChildAdded:connect(function(Child)
	for i = 1,50 do
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		wait();
	end
end)

--[[game:GetService("UserInputService").InputBegan:connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.ButtonL1 then
		for _,Obj in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if Obj:IsA("Tool") then
				Obj.Parent = game.Players.LocalPlayer.Character;
				return;
			end
		end
		for _,Obj in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if Obj:IsA("Tool") then
				Obj.Parent = game.Players.LocalPlayer.Backpack;
				return;
			end
		end
	end
end)]]