from fastapi import FastAPI
from mediaflow_proxy.main import app as mediaflow_app  # mediaflow app import

main_app = FastAPI()

# Sadece non-static route'ları ekle
for route in mediaflow_app.routes:
    if route.path != "/":  
        main_app.router.routes.append(route)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(main_app, host="0.0.0.0", port=8080)
