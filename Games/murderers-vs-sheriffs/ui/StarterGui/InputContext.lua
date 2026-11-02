-- Generated from ui/StarterGui/InputContext.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("ScreenGui", nil, "InputContext", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Folder", I[1], "Console")
			I[3] = new("InputContext", I[2], "Dock", { Enabled = false, Priority = 2200, Sink = true })
				I[4] = new("InputAction", I[3], "CloseDock")
					I[5] = new("InputBinding", I[4], "Binding", { KeyCode = Enum.KeyCode.ButtonB })
				I[6] = new("InputAction", I[3], "Spectate")
					I[7] = new("InputBinding", I[6], "Binding", { KeyCode = Enum.KeyCode.ButtonY })
				I[8] = new("InputAction", I[3], "Shop")
					I[9] = new("InputBinding", I[8], "Binding", { KeyCode = Enum.KeyCode.ButtonX })
				I[10] = new("InputAction", I[3], "Inventory")
					I[11] = new("InputBinding", I[10], "Binding", { KeyCode = Enum.KeyCode.ButtonA })
			I[12] = new("InputContext", I[2], "Main", { Priority = 2100 })
				I[13] = new("InputAction", I[12], "OpenDock")
					I[14] = new("InputBinding", I[13], "Binding", { KeyCode = Enum.KeyCode.ButtonX })
			I[15] = new("InputContext", I[2], "Shop", { Enabled = false, Priority = 2300, Sink = true })
				I[16] = new("InputAction", I[15], "Back")
					I[17] = new("InputBinding", I[16], "Binding", { KeyCode = Enum.KeyCode.ButtonB })
				I[18] = new("InputAction", I[15], "ButtonX")
					I[19] = new("InputBinding", I[18], "Binding", { KeyCode = Enum.KeyCode.ButtonX })
				I[20] = new("InputAction", I[15], "NavigateLeft")
					I[21] = new("InputBinding", I[20], "Binding", { KeyCode = Enum.KeyCode.ButtonL1 })
				I[22] = new("InputAction", I[15], "NavigateRight")
					I[23] = new("InputBinding", I[22], "Binding", { KeyCode = Enum.KeyCode.ButtonR1 })
			I[24] = new("InputContext", I[2], "Inventory", { Enabled = false, Priority = 2300, Sink = true })
				I[25] = new("InputAction", I[24], "Back")
					I[26] = new("InputBinding", I[25], "Binding", { KeyCode = Enum.KeyCode.ButtonB })
				I[27] = new("InputAction", I[24], "ButtonX")
					I[28] = new("InputBinding", I[27], "Binding", { KeyCode = Enum.KeyCode.ButtonX })
				I[29] = new("InputAction", I[24], "NavigateLeft")
					I[30] = new("InputBinding", I[29], "Binding", { KeyCode = Enum.KeyCode.ButtonL1 })
				I[31] = new("InputAction", I[24], "NavigateRight")
					I[32] = new("InputBinding", I[31], "Binding", { KeyCode = Enum.KeyCode.ButtonR1 })
			I[33] = new("InputContext", I[2], "Spectate", { Enabled = false, Priority = 2250, Sink = true })
				I[34] = new("InputAction", I[33], "Back")
					I[35] = new("InputBinding", I[34], "Binding", { KeyCode = Enum.KeyCode.ButtonB })
				I[36] = new("InputAction", I[33], "NavigateLeft")
					I[37] = new("InputBinding", I[36], "Binding", { KeyCode = Enum.KeyCode.ButtonL1 })
				I[38] = new("InputAction", I[33], "NavigateRight")
					I[39] = new("InputBinding", I[38], "Binding", { KeyCode = Enum.KeyCode.ButtonR1 })
		I[40] = new("InputContext", I[1], "BackpackContext")
			I[41] = new("InputAction", I[40], "Item1")
				I[42] = new("InputBinding", I[41], "InputBinding", { KeyCode = Enum.KeyCode.One })
			I[43] = new("InputAction", I[40], "Item2")
				I[44] = new("InputBinding", I[43], "InputBinding", { KeyCode = Enum.KeyCode.Two })
			I[45] = new("InputAction", I[40], "Item3")
				I[46] = new("InputBinding", I[45], "InputBinding", { KeyCode = Enum.KeyCode.Three })
			I[47] = new("InputAction", I[40], "Item4")
				I[48] = new("InputBinding", I[47], "InputBinding", { KeyCode = Enum.KeyCode.Four })
			I[49] = new("InputAction", I[40], "Item5")
				I[50] = new("InputBinding", I[49], "InputBinding", { KeyCode = Enum.KeyCode.Five })
			I[51] = new("InputAction", I[40], "Item6")
				I[52] = new("InputBinding", I[51], "InputBinding", { KeyCode = Enum.KeyCode.Six })
			I[53] = new("InputAction", I[40], "Item7")
				I[54] = new("InputBinding", I[53], "InputBinding", { KeyCode = Enum.KeyCode.Seven })
			I[55] = new("InputAction", I[40], "Item8")
				I[56] = new("InputBinding", I[55], "InputBinding", { KeyCode = Enum.KeyCode.Eight })
			I[57] = new("InputAction", I[40], "Item9")
				I[58] = new("InputBinding", I[57], "InputBinding", { KeyCode = Enum.KeyCode.Nine })
			I[59] = new("InputAction", I[40], "Item10")
				I[60] = new("InputBinding", I[59], "InputBinding", { KeyCode = Enum.KeyCode.Zero })
			I[61] = new("InputAction", I[40], "GamepadRight")
				I[62] = new("InputBinding", I[61], "InputBinding", { KeyCode = Enum.KeyCode.ButtonR1 })
			I[63] = new("InputAction", I[40], "GamepadLeft")
				I[64] = new("InputBinding", I[63], "InputBinding", { KeyCode = Enum.KeyCode.ButtonL1 })
			I[65] = new("InputAction", I[40], "GamepadUnequip")
				I[66] = new("InputBinding", I[65], "InputBinding", { KeyCode = Enum.KeyCode.ButtonB })
		I[67] = new("InputContext", I[1], "EmoteContext", { Priority = 2000 })
			I[68] = new("InputAction", I[67], "Emote1")
				I[69] = new("InputBinding", I[68], "KeyboardBinding", { KeyCode = Enum.KeyCode.One })
			I[70] = new("InputAction", I[67], "Emote2")
				I[71] = new("InputBinding", I[70], "KeyboardBinding", { KeyCode = Enum.KeyCode.Two })
			I[72] = new("InputAction", I[67], "Emote3")
				I[73] = new("InputBinding", I[72], "KeyboardBinding", { KeyCode = Enum.KeyCode.Three })
			I[74] = new("InputAction", I[67], "Emote4")
				I[75] = new("InputBinding", I[74], "KeyboardBinding", { KeyCode = Enum.KeyCode.Four })
			I[76] = new("InputAction", I[67], "Emote5")
				I[77] = new("InputBinding", I[76], "KeyboardBinding", { KeyCode = Enum.KeyCode.Five })
			I[78] = new("InputAction", I[67], "Emote6")
				I[79] = new("InputBinding", I[78], "KeyboardBinding", { KeyCode = Enum.KeyCode.Six })
			I[80] = new("InputAction", I[67], "Emote7")
				I[81] = new("InputBinding", I[80], "KeyboardBinding", { KeyCode = Enum.KeyCode.Seven })
			I[82] = new("InputAction", I[67], "Emote8")
				I[83] = new("InputBinding", I[82], "KeyboardBinding", { KeyCode = Enum.KeyCode.Eight })
			I[84] = new("InputAction", I[67], "ScrollUp")
				I[85] = new("InputBinding", I[84], "KeyboardBinding", { KeyCode = Enum.KeyCode.Q })
			I[86] = new("InputAction", I[67], "ScrollDown")
				I[87] = new("InputBinding", I[86], "KeyboardBinding", { KeyCode = Enum.KeyCode.E })
			I[88] = new("InputAction", I[67], "ScrollRight")
				I[89] = new("InputBinding", I[88], "KeyboardBinding", { KeyCode = Enum.KeyCode.R })
				I[90] = new("InputBinding", I[88], "TouchBindinng")
			I[91] = new("InputAction", I[67], "ScrollLeft")
			I[92] = new("InputAction", I[67], "Cancel")
				I[93] = new("InputBinding", I[92], "GamepadBinding", { KeyCode = Enum.KeyCode.ButtonB })
		I[94] = new("InputContext", I[1], "GameplayContext", { Priority = 1500 })
			I[95] = new("InputAction", I[94], "EquipWeapon")
				I[96] = new("InputBinding", I[95], "TouchBinding")
			I[97] = new("InputAction", I[94], "Perk")
				I[98] = new("InputBinding", I[97], "TouchBinding", { KeyCode = Enum.KeyCode.Q })
				I[99] = new("InputBinding", I[97], "GamepadBinding", { KeyCode = Enum.KeyCode.ButtonX })
			I[100] = new("InputAction", I[94], "Throw")
				I[101] = new("InputBinding", I[100], "TouchBinding")
				I[102] = new("InputBinding", I[100], "KeyboardBinding", { KeyCode = Enum.KeyCode.E })
				I[103] = new("InputBinding", I[100], "GamepadBinding", { KeyCode = Enum.KeyCode.ButtonL2 })
			I[104] = new("InputAction", I[94], "Emotes")
				I[105] = new("InputBinding", I[104], "KeyboardBinding", { KeyCode = Enum.KeyCode.T })
				I[106] = new("InputBinding", I[104], "GamepadBinding", { KeyCode = Enum.KeyCode.DPadRight })
	return I[1]
end

return build
