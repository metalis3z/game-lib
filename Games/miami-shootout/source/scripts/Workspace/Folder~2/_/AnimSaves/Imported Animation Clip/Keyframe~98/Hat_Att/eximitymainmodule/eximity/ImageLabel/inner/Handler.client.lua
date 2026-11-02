-- Decompiled with the Synapse X Luau decompiler.

for v1, v2 in pairs(script.Parent:GetChildren()) do
	if v2:IsA("Frame") and v2.Name ~= "Home" then
		v2.Visible = false;
	elseif v2:IsA("Frame") and v2.Name == "Home" then
		v2.Visible = true;
	end;
end;
