local isHalloween2021 = workspace:GetAttribute("Halloween2021")
if isHalloween2021 then
	require(script.Halloween2021)
else
	script.Halloween2021:Destroy() -- cannot be stolen.
end

local isChristmas2021 = workspace:GetAttribute("Christmas2021")
if isChristmas2021 then
	require(script.Christmas2021)
else
	script.Christmas2021:Destroy() -- cannot be stolen.
end