import requests
import os

def send_to_telegram(token, chat_id, file_path, caption=""):
    """
    Sends the generated zip file as a document via the Telegram Bot API.
    """
    if not token or token == "your_telegram_bot_token_here":
        raise ValueError("Please configure a valid TELEGRAM_BOT_TOKEN in your .env file.")
    if not chat_id or chat_id == "your_chat_id_here":
        raise ValueError("Please configure a valid CHAT_ID in your .env file.")

    url = f"https://api.telegram.org/bot{token}/sendDocument"

    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Archive file not found: {file_path}")

    payload = {
        "chat_id": chat_id,
        "caption": caption
    }

    with open(file_path, "rb") as f:
        files = {
            "document": (os.path.basename(file_path), f)
        }
        response = requests.post(url, data=payload, files=files)

    if not response.ok:
        raise RuntimeError(f"Telegram API Error: {response.status_code} - {response.text}")

    return response.json()
