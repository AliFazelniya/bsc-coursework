import requests

response = requests.get("http://api.navasan.tech/latest/",
                        params={"api_key": "freeFVmjXMEYIZGV0CPuirmOyc36r6Wq"})
data = response.json()
def usd():
    usd_list = []
    usd_change = data['usd_sell']["change"]
    usd_sell = data['usd_sell']["value"]
    usd_list.append(usd_sell)
    usd_list.append(usd_change)
    return usd_list
def euro():
    euro_list = []
    euro_sell = data["eur_hav"]["value"]
    euro_change = data["eur_hav"]["change"]
    euro_list.append(euro_sell)
    euro_list.append(euro_change)
    return euro_list    
def pond():
    pond_list = []
    pond_sell = data["gbp_hav"]["value"]
    pond_change = data["gbp_hav"]["change"]
    pond_list.append(pond_sell)
    pond_list.append(pond_change)
    return pond_list
def bitcoin():
    btc_list = []
    btc_sell = data["btc"]["value"]
    btc_change = data["btc"]["change"]
    btc_list.append(btc_sell)
    btc_list.append(btc_change)
    return btc_list
def coin():
    coin_list = []
    coin_sell = data["bahar"]["value"]
    coin_change = data["bahar"]["change"]
    coin_list.append(coin_sell)
    coin_list.append(coin_change)
    return coin_list
def ether():
    ether_list = []
    ether_sell = data["eth"]["value"]
    ether_change = data["eth"]["change"]
    ether_list.append(ether_sell)
    ether_list.append(ether_change)
    return ether_list