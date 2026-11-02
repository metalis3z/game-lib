-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent;
local v2 = 1
local function v4() --[[ Line: 14 ]] --[[ Name: onActivated ]]
	if os.clock() - v2 < 10 then
		return;
	else
		v2 = os.clock();
		task.wait(0.6)
		script.Parent.Handle.Particle1:Emit(15)
		return;
	end;
end;
l_Parent_0.Activated:Connect(v4);
