getgenv().oxyX_premium = true
local u = "https://raw.githubusercontent.com/johsua092-ui/script-premium/main/babft-script-main/oxyX_AutoBuild.lua"

local function fetch(url)
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if ok and type(body) == "string" and #body > 0 then return body end
    local R = (syn and syn.request) or request or http_request
    local res = R and R({Url = url, Method = "GET"})
    return (res and res.Body) or nil
end

local src = fetch(u)
assert(src and #src > 0, "Gagal mengambil script: periksa URL dan visibilitas repo")
local fn = loadstring(src)
assert(fn, "Gagal memuat script")
fn()
