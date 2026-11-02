local themes = {}
for _, v in pairs(script:GetChildren()) do
	if v:IsA("ModuleScript") then
		themes[v.Name] = require(v)
	end
end
return themes