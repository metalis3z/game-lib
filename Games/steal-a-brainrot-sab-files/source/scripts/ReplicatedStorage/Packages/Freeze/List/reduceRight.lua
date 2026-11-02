

local reduce = require(script.Parent.Parent.utils.reduce)

local function reduceRight(t1: {[any]: any}, p1: ((...any) -> ...any), p2)
	return reduce(t1, p1, p2, true)
end

return reduceRight
