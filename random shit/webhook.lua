local url = ''
local http = game:GetService("HttpService")
local pf = {}
local gc = getgc(true)
local username = game:GetService("Players").LocalPlayer.Name
for i = 1, #gc do
    local garbage = gc[i]
    local gc_type = type(garbage)

    if gc_type == "function" then
        local name = getinfo(garbage).name
        if name == "rankCalculator" then
            pf.rankCalculator = garbage
        end
    end
    if gc_type == "table" then
       if rawget(garbage, "unlocks") then
            pf.dirtyplayerdata = garbage
    end
end
end
local pf_data = {
    xp = pf.dirtyplayerdata.stats.experience,
    money = pf.dirtyplayerdata.stats.money,
    kills = pf.dirtyplayerdata.stats.totalkills,
    deaths = pf.dirtyplayerdata.stats.totaldeaths,
    rank = pf.rankCalculator(pf.dirtyplayerdata.stats.experience),
}

local data = {
    ['embeds'] = {{
        ['username'] = "PF Stats",
        ['title'] = string.format("%s's PF Stats", username),
        ['description'] = string.format("Rank: %s\nXP: %s\nMoney: %s\nKills: %s\nDeaths: %s", pf_data.rank, pf_data.xp, pf_data.money, pf_data.kills, pf_data.deaths),
        ['color'] = tonumber(0x00ff00),
        ['footer'] = {
            ['text'] = "PF Stats"
        }
    }}
}

local req = syn.request(
    {
        Url = url,
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = http:JSONEncode(data)
    }
)