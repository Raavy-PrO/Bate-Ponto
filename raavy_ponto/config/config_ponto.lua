local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Proxy.addInterface(GetCurrentResourceName(), Config)
Config = {}

-- variaveis de teste para ficar mais facil


Config["locs"] = { -- localizações no  mapa 
    ["Policia"] = {['x'] = -505.35, ['y'] = -257.95, ['z'] = 35.5, ["blip"] = 2, ["color"] = {255,255,255,255}, ["rotate"] = true, ["effect"] = true, ["sync"] = true},
    
}


Config["Webhooks"] = { -- WEBHOOKS

    ["Policia"] = "https://discord.com/api/webhooks/977069372533276672/zQfTBoMYyyf-5BkRWFk1S1TAC8rkyiCjBnq838JdqvJ0Jq-ECSYBSDgD-yvYGsdjlYQg",
}

Config["permissao"] = { -- permissao para sair e entra em servico
    ["PoliciaF"] = "policia3-foradeservico.permissao",
    ["PoliciaS"] = "policia.permissao"
}

Config["groups"] = { -- grupos para alterar ingame
    ["Policialservico"] =  "Policia3",
    ["Policialfora"] = "Policia3-ForaDeServico"
}

return Config