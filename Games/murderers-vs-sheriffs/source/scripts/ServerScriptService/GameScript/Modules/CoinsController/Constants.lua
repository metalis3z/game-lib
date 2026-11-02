local CoinsFolder = game.ReplicatedStorage.Coins
local Constants = {
	SpawnEnabled = false,
	Server_Part = game.ServerStorage.Gameplay.Coin_Server,
	MaxCoinAmount = 250,
	SpawnDelay = 0.5,
	Data = {
		Coin = {
			Model = CoinsFolder.CoinObjects.Coin,
			Sound = game.ReplicatedStorage.Coins.Sounds.CoinSound,
			Max = {
				Default = 40,
				Elite = 50
			},
			RandomSpawn = false;
			Chances = 99,
			Reward = {
				{Prize = "Coins", Type = "Materials", Amount = 1}
			}
		};
	}
}

return Constants