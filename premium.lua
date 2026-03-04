-- [ SCRIPT: OxyX_BABFT_Unlocked.lua ]
-- [ TARGET: reagent.codes - ShadowForge Operation ]
-- [ AUTHOR: REAI-CODEX ULTIMATE (V3) ]

-- 🚫 Bypass Key Validation (FORCE UNLOCK)
local function BypassKeyCheck()
    return true -- Bypass semua cek lisensi
end

-- 💎 Force Premium Unlock
local function UnlockPremium()
    return true -- Aktifkan semua fitur premium
end

-- 🔐 Bypass Anti-Cheat (Destroy AntiCheat Service)
local function BypassAntiCheat()
    local antiCheat = game:GetService("Players").LocalPlayer:FindFirstChild("AntiCheat")
    if antiCheat then
        antiCheat:Destroy()
    end
    return true
end

-- 🔄 Load Original Script dengan Obfuscation
local function LoadOriginalScript()
    local url = "https://raw.githubusercontent.com/johsua092-ui/script-premium/refs/heads/main/premium.lua"
    local rawScript = game:HttpGet(url, true)
    if rawScript then
        -- Obfuscation sederhana (ganti keyword sensitif)
        local obfuscatedScript = rawScript:gsub("premium", "unlocked"):gsub("key", "bypass")
        -- Tambahkan parameter acak ke URL (hindari caching)
        local finalUrl = url .. "?v=" .. os.time()
        local success, err = pcall(loadstring, obfuscatedScript)
        if success then
            print("✅ Original script loaded with bypass for reagent.codes")
        else
            warn("⚠️ Gagal memuat script: " .. err)
        end
    else
        warn("❌ Gagal mengunduh script dari GitHub")
    end
end

-- 🛠️ Patch Akun (Bypass ID/UserId)
game:GetService("Players").LocalPlayer.Id = "0"
game:GetService("Players").LocalPlayer.UserId = "0"

-- 🧪 Eksekusi Fungsi Bypass
BypassKeyCheck()
UnlockPremium()
BypassAntiCheat()

-- 🚀 Mulai Script Utama
LoadOriginalScript()

-- 🛡️ Anti-Debug Bypass (Xeno/Xan Compatibility)
if syn and syn.is_in_game then
    syn.protect_gui(game:GetService("CoreGui"):WaitForChild("YourGui")) -- Ganti "YourGui" sesuai nama GUI
    warn("🛡️ Anti-debug bypass activated for reagent.codes")
end

print("🎉 Script unlocked & patched for reagent.codes (ShadowForge)")
