



local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Conch)
local v3 = {}
for _, v4 in require(v1.Datas.FuseMachineData).LuckMultipliers do
	v3[tostring(v4)] = v4
end
return v2.register_type("FuseMachineLuck", v2.args.enum_map(v3))