-- kamidere loader

local KEY = _G.KAMI_KEY or "KAMI-XXXX-XXXX-XXXX"
local API = "https://kamidere-api.fly.dev/verify"
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local function kickPlayer(msg)
    local ok, _ = pcall(function()
        Players.LocalPlayer:Kick(msg)
    end)
    if not ok then error(msg, 0) end
    task.wait(999)
end

local function getHWID()
    local ok1, id = pcall(function()
        return tostring(game:GetService("RbxAnalyticsService"):GetClientId())
    end)
    if ok1 and id and id ~= "" then return id end
    local ok2, ex = pcall(function() return identifyexecutor() end)
    if ok2 and ex then return ex end
    return tostring(game.PlaceId) .. tostring(Players.LocalPlayer.UserId)
end

local hwid = getHWID()

local httpFn
local _candidates = {"syn", "request", "http_request", "fluxus_request", "http"}
for _, name in ipairs(_candidates) do
    local ok, fn = pcall(function()
        local g = getfenv and getfenv(0) or _G
        local v = g[name]
        if type(v) == "table" and type(v.request) == "function" then return v.request end
        if type(v) == "function" then return v end
    end)
    if ok and fn then httpFn = fn break end
end

if not httpFn then
    kickPlayer("Invalid key\nMake a ticket in the discord server! \ndiscord.gg/kamidere")
end

local ok, response = pcall(function()
    return httpFn({
        Url     = API,
        Method  = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body    = HttpService:JSONEncode({ key = KEY, hwid = hwid }),
    })
end)

if not ok or not response then
    kickPlayer("Invalid key\nMake a ticket in the discord server! \ndiscord.gg/kamidere")
end

local body = HttpService:JSONDecode(response.Body)

if not body.valid then
    if body.reason == "hwid_mismatch" then
        kickPlayer("HWID Mismatch please reset your HWID!")
    else
        kickPlayer("Invalid key\nMake a ticket in the discord server! \ndiscord.gg/kamidere")
    end
end

local scriptUrl = "https://kamidere-api.fly.dev/script?key=" .. KEY .. "&hwid=" .. hwid
local ok2, scriptSrc = pcall(function() return httpFn({ Url = scriptUrl, Method = "GET" }) end)
if not ok2 or not scriptSrc or not scriptSrc.Body or scriptSrc.Body:sub(1,2) == "--" then
    kickPlayer("Invalid key\nMake a ticket in the discord server! \ndiscord.gg/kamidere")
end
loadstring(scriptSrc.Body)()
