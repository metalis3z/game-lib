--!strict
-- LOCATION: ReplicatedStorage/Modules/ProductConfigurations

local ProductConfigurations = {}

-- [ Developer Products ]
ProductConfigurations.X2TouchWinsId = nil 
ProductConfigurations.SkipRebirthId = 3604735966 
ProductConfigurations.ReviveId = 3604736003 
ProductConfigurations.SpeedProducts = {
	{ Id = 3604734537, Amount = 25000 },     -- Product1 (Small)
	{ Id = 3604734559, Amount = 100000 },    -- Product2 (Medium)
	{ Id = 3604734586, Amount = 500000 },   -- Product3 (Large)
}

-- [ Game Passes ]
ProductConfigurations.GoldTreadmillGP = 1876252003
ProductConfigurations.DiamondTreadmillGP = 1876150073
ProductConfigurations.DoubleWinsGP = 1874926059
ProductConfigurations.SpeedPeakTiers = {
	{ Level = 2, Id = 1875190086 }, -- Buys x2
	{ Level = 3, Id = 1875412018 }, -- Buys x3
	{ Level = 4, Id = 1874650018 }, -- Buys x4
	{ Level = 5, Id = 1875783977 }, -- Buys x5

}

return ProductConfigurations