
local Xbox_ReturnValues_List = {
	"ButtonA", "ButtonB", "ButtonX", "ButtonY", "ButtonLB", "ButtonLT", "ButtonLS",
	"ButtonRB", "ButtonRT", "ButtonRS", "ButtonStart", "ButtonSelect"
};
local PlayStation_ReturnValues_List = {
	"ButtonCross", "ButtonCircle", "ButtonSquare", "ButtonTriangle", "ButtonL1", 
	"ButtonL2", "ButtonL3", "ButtonR1", "ButtonR2", "ButtonR3", "ButtonOptions", 
	"ButtonTouchpad", "ButtonShare"
};

return function(p1)
	local v2 = require(game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("MainUI"):WaitForChild("Initiator").Main_Game);
	local v2 = game:GetService("Players").LocalPlayer:GetAttributes();
	local u1 = {
		inputTypeThePlayerIsUsing = "None",
		gamepadType = "None",
	};
	local stringForKeyCodePressed = game:GetService("UserInputService"):GetStringForKeyCode(p1);
	for _, retunValue_Xbox in pairs(Xbox_ReturnValues_List) do
		if retunValue_Xbox == stringForKeyCodePressed then
			print("console: xbox");
			u1.gamepadType = "Xbox";
		end;
	end;
	u1.inputTypeThePlayerIsUsing = "Gamepad";
	for _, returnValue_PlayStation in pairs(PlayStation_ReturnValues_List) do
		if returnValue_PlayStation == stringForKeyCodePressed then
			print("console: ps");
			u1.gamepadType = "PlayStation";
		end;
	end;
	--repeat task.wait(0.01) until u1.inputTypeThePlayerIsUsing == "Gamepad";
	wait();
	print("dtected Input: "..tostring(u1.inputTypeThePlayerIsUsing));
	print("dtected gamepad: "..tostring(u1.gamepadType));
	if u1.inputTypeThePlayerIsUsing == "Gamepad" then
		if v2.force_device == false then
			if u1.gamepadType == "Xbox" then
				return {
					ButtonX = "rbxassetid://9876149963", 
					ButtonY = "rbxassetid://9876149854", 
					ButtonA = "rbxassetid://9876150181", 
					ButtonB = "rbxassetid://9876150092"
				}
			elseif u1.gamepadType == "PlayStation" then
				return {
					ButtonX = "rbxassetid://14976826621", 
					ButtonY = "rbxassetid://14976826715", 
					ButtonA = "rbxassetid://14976826530", 
					ButtonB = "rbxassetid://14976826417"
				}
			end;
		else
			if v2.Console_Input_Type == "xbox" then
				return {
					ButtonX = "rbxassetid://9876149963", 
					ButtonY = "rbxassetid://9876149854", 
					ButtonA = "rbxassetid://9876150181", 
					ButtonB = "rbxassetid://9876150092"
				}
			elseif v2.Console_Input_Type == "ps" then
				return {
					ButtonX = "rbxassetid://14976826621", 
					ButtonY = "rbxassetid://14976826715", 
					ButtonA = "rbxassetid://14976826530", 
					ButtonB = "rbxassetid://14976826417"
				}
			end;
		end
	end;
end;