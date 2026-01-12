from fastapi import FastAPI
from mediaflow_proxy.main import app as mediaflow_app

# Ana uygulamayı başlat
main_app = FastAPI()

# mediaflow_app içindeki route'ları ekle ("/" hariç)
for route in mediaflow_app.routes:
    if route.path != "/":
        main_app.router.routes.append(route)

# Docker CMD ile çalıştırıldığı için if __name__ == "__main__": bloğu opsiyonel
# Ama geliştirme için istersen port 8888 ile çalıştırabilirsin
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(main_app, host="0.0.0.0", port=8888)

