import requests
import os
from dotenv import load_dotenv

load_dotenv()
API_KEY = os.getenv("NAVASAN_API_KEY")

def get_currency_data(currency_key):
    try:
        response = requests.get(
            "http://api.navasan.tech/latest/",
            params={"api_key": API_KEY},
            timeout=5
        )
        response.raise_for_status()
        data = response.json()
        

        if currency_key in data:
            item = data[currency_key]
            return [item.get("value", "N/A"), item.get("change", "N/A")]
        else:
            return ["N/A", "N/A"]
            
    except requests.RequestException:
        # مدیریت خطاهای شبکه (مثل قطعی اینترنت)
        return ["Error", "Error"]