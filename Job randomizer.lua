local JobJob = {
--  Tanks
    "Paladin", "Warrior", "Dark Knight", "Gunbreaker",
--  Melee
    "Monk", "Dragoon", "Ninja", "Samurai", "Reaper", "Viper",
--  Phys ranged
    "Bard", "Machinist", "Dancer",
--  Casters
    "Black Mage", "Summoner", "Red Mage", "Pictomancer",
--  Healers
    "White Mage", "Scholar", "Astrologian", "Sage"
}

local randomIndex = math.random(1, #JobJob)
--Engines.Native.Run("/echo Gods of random say: today I shall play "..JobJob[randomIndex])
Engines.Native.Run("/p Gods of random say: today I shall play "..JobJob[randomIndex])
Engines.Native.Run("/gs change "..JobJob[randomIndex])
