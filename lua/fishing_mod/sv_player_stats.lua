sql.Query([[CREATE TABLE IF NOT EXISTS fishingmod_data (
	steamid INTEGER PRIMARY KEY,
	catches INTEGER,
	exp INTEGER,
	money INTEGER,
	length INTEGER,
	reel_speed INTEGER,
	string_length INTEGER,
	force INTEGER
)]])

function fishingmod.SavePlayerInfo(ply, name, value)
	local steamid = ply:SteamID64()
	sql.QueryTyped("INSERT OR IGNORE INTO fishingmod_data (steamid) VALUES (?)", steamid)
	sql.QueryTyped("UPDATE fishingmod_data SET " .. name .. " = ? WHERE steamid = ?", value, steamid)
end

function fishingmod.LoadPlayerInfo(ply)
	local info = sql.QueryTyped("SELECT catches, exp, money, length, reel_speed, string_length, force FROM fishingmod_data WHERE steamid = ? LIMIT 1", ply:SteamID64())
	return info[1]
end

function fishingmod.GainEXP(ply, amount)
	ply.fishingmod.exp = ply.fishingmod.exp + amount
	ply.fishingmod.catches = ply.fishingmod.catches + 1
	fishingmod.SavePlayerInfo(ply, "exp", ply.fishingmod.exp)
	fishingmod.SavePlayerInfo(ply, "catches", ply.fishingmod.catches)
	fishingmod.UpdatePlayerInfo(ply)
end

function fishingmod.GiveMoney(ply, amount)
	ply.fishingmod.money = ply.fishingmod.money or 0
	ply.fishingmod.money = ply.fishingmod.money + amount
	fishingmod.SavePlayerInfo(ply, "money", ply.fishingmod.money)
	fishingmod.UpdatePlayerInfo(ply)
end

function fishingmod.Pay(ply, money)
	if ply.fishingmod.money >= money then
		fishingmod.TakeMoney(ply, money)
		return true
	end

	return false
end

function fishingmod.TakeMoney(ply, amount)
	ply.fishingmod.money = ply.fishingmod.money - amount
	fishingmod.SavePlayerInfo(ply, "money", ply.fishingmod.money)
	fishingmod.UpdatePlayerInfo(ply)
end

function fishingmod.SetRodLength(ply, length, add_or_sub)
	if add_or_sub == "add" then
		ply.fishingmod.length = ply.fishingmod.length + length
	elseif add_or_sub == "sub" then
		ply.fishingmod.length = ply.fishingmod.length - length
	else
		ply.fishingmod.length = length
	end

	fishingmod.SavePlayerInfo(ply, "length", ply.fishingmod.length)
	fishingmod.UpdatePlayerInfo(ply)
end

function fishingmod.SetRodReelSpeed(ply, speed, add_or_sub)
	if add_or_sub == "add" then
		ply.fishingmod.reel_speed = ply.fishingmod.reel_speed + speed
	elseif add_or_sub == "sub" then
		ply.fishingmod.reel_speed = ply.fishingmod.reel_speed - speed
	else
		ply.fishingmod.reel_speed = speed
	end

	fishingmod.SavePlayerInfo(ply, "reel_speed", ply.fishingmod.reel_speed)
	fishingmod.UpdatePlayerInfo(ply)
end

function fishingmod.SetRodStringLength(ply, length, add_or_sub)
	if add_or_sub == "add" then
		ply.fishingmod.string_length = ply.fishingmod.string_length + length
	elseif add_or_sub == "sub" then
		ply.fishingmod.string_length = ply.fishingmod.string_length - length
	else
		ply.fishingmod.string_length = length
	end

	fishingmod.SavePlayerInfo(ply, "string_length", ply.fishingmod.string_length)
	fishingmod.UpdatePlayerInfo(ply)
end

function fishingmod.SetHookForce(ply, force, add_or_sub)
	if add_or_sub == "add" then
		ply.fishingmod.force = ply.fishingmod.force + force
	elseif add_or_sub == "sub" then
		ply.fishingmod.force = ply.fishingmod.force - force
	else
		ply.fishingmod.force = force
	end

	fishingmod.SavePlayerInfo(ply, "force", ply.fishingmod.force)
	fishingmod.UpdatePlayerInfo(ply)
end

sql.Query([[CREATE TABLE IF NOT EXISTS fishingmod_data (
	steamid INTEGER PRIMARY KEY,
	catches INTEGER,
	exp INTEGER,
	money INTEGER,
	length INTEGER,
	reel_speed INTEGER,
	string_length INTEGER,
	force INTEGER
)]])

function fishingmod.InitPlayerStats(ply)
	if not IsValid(ply) then return end

	local info = fishingmod.LoadPlayerInfo(ply)

	ply.fishingmod = {
		catches = info.catches or 0,
		exp = info.exp or 0,
		money = info.money or 0,
		length = info.length or 0,
		reel_speed = info.reel_speed or 0,
		string_length = info.string_length or 0,
		force = info.force or 0
	}

	fishingmod.UpdatePlayerInfo(ply, true)
end