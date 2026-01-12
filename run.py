from fastapi import FastAPI
from mediaflow_proxy.main import app as mediaflow_app  # Import mediaflow app

# Ana FastAPI uygulaması
main_app = FastAPI()

# mediaflow_app içindeki route'ları ekle ("/" hariç)
for route in mediaflow_app.routes:
    if route.path != "/":
        main_app.router.routes.append(route)

# Geliştirme/test için doğrudan çalıştırma
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(main_app, host="0.0.0.0", port=7860)

