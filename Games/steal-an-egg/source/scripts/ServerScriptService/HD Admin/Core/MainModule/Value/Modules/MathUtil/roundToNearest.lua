local function roundToNearest(number: number, mult: number): number
	-- We divide instead of multiply to avoid overflowing digits
	-- (like 0.200000000000000000000001)
	return (math.round(number / mult)) / (1/mult)
end
return roundToNearest