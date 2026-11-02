-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved soon!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-12-27 06:59:34
-- Luau version 6, Types version 3
-- Time taken: 0.001115 seconds

script.Parent.ChildAdded:Connect(function(arg1) -- Line 1, Named "handle"
	local Head = script.Parent.Mic:FindFirstChild("Head")
	if not Head then
	else
		arg1:WaitForChild("Wire").SourceInstance = Head:WaitForChild("AudioListener", 1)
	end
end)
script.Parent.Mic.ChildAdded:Connect(function(arg1) -- Line 8
	if arg1.Name ~= "Head" then
	else
		if script.Parent:FindFirstChild("Speaker1") then
			local Head_5 = script.Parent.Mic:FindFirstChild("Head")
			if not Head_5 then
			else
				script.Parent.Speaker1:WaitForChild("Wire").SourceInstance = Head_5:WaitForChild("AudioListener", 1)
			end
		end
		if script.Parent:FindFirstChild("Speaker2") then
			local Head_2 = script.Parent.Mic:FindFirstChild("Head")
			if not Head_2 then return end
			script.Parent.Speaker2:WaitForChild("Wire").SourceInstance = Head_2:WaitForChild("AudioListener", 1)
		end
	end
end)
local Head_3 = script.Parent.Mic:FindFirstChild("Head")
if not Head_3 then
else
	script.Parent.Speaker1:WaitForChild("Wire").SourceInstance = Head_3:WaitForChild("AudioListener", 1)
end
local Head_4 = script.Parent.Mic:FindFirstChild("Head")
if not Head_4 then
else
	script.Parent.Speaker2:WaitForChild("Wire").SourceInstance = Head_4:WaitForChild("AudioListener", 1)
end